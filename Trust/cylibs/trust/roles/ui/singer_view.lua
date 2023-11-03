local CollectionView = require('cylibs/ui/collection_view/collection_view')
local CollectionViewDataSource = require('cylibs/ui/collection_view/collection_view_data_source')
local Color = require('cylibs/ui/views/color')
local IndexedItem = require('cylibs/ui/collection_view/indexed_item')
local IndexPath = require('cylibs/ui/collection_view/index_path')
local Padding = require('cylibs/ui/style/padding')
local TextCollectionViewCell = require('cylibs/ui/collection_view/cells/text_collection_view_cell')
local TextItem = require('cylibs/ui/collection_view/items/text_item')
local TextStyle = require('cylibs/ui/style/text_style')
local VerticalFlowLayout = require('cylibs/ui/collection_view/layouts/vertical_flow_layout')

local SingerView = setmetatable({}, {__index = CollectionView })
SingerView.__index = SingerView
SingerView.__type = 'SingerView'

TextStyle.SingerView = {
    Text = TextStyle.new(
            Color.clear,
            Color.clear,
            "Arial",
            11,
            Color.white,
            Color.yellow,
            2,
            0,
            0,
            false
    ),
}

function SingerView.new(singer)
    local dataSource = CollectionViewDataSource.new(function(item)
        local cell = TextCollectionViewCell.new(item)
        cell:setItemSize(20)
        return cell
    end)

    local self = setmetatable(CollectionView.new(dataSource, VerticalFlowLayout.new(2, Padding.new(10, 15, 0, 0))), SingerView)

    self.singer = singer

    local partyMember = self.singer:get_party():get_player()

    self:getDisposeBag():add(partyMember:on_gain_buff():addAction(function(_, buffId)
        if self.singer.brd_job:is_bard_song_buff(buffId) then
            self:reloadActiveSongs()
        end
    end), partyMember:on_gain_buff())

    self:reloadActiveSongs()

    return self
end

function SingerView:destroy()
    self.singer = nil

    CollectionView.destroy(self)
end

function SingerView:layoutIfNeeded()
    CollectionView.layoutIfNeeded(self)

    self:setTitle("View current songs on the player.")
end

function SingerView:reloadActiveSongs()
    self:getDataSource():removeAllItems()

    local partyMember = self.singer:get_party():get_player()
    local buffIds = L(partyMember:get_buff_ids())

    local itemsToAdd = L{}
    local itemsToHighlight = L{}

    local sectionNum = 1

    local dummySongs = self.singer:get_dummy_songs()
    itemsToAdd:append(IndexedItem.new(TextItem.new("Dummy Songs", TextStyle.Default.HeaderSmall), IndexPath.new(sectionNum, 1)))
    local currentRow = 2
    for song in dummySongs:it() do
        local item = TextItem.new('• '..song:description(), TextStyle.SingerView.Text)
        local indexPath = IndexPath.new(sectionNum, currentRow)
        itemsToAdd:append(IndexedItem.new(item, indexPath))
        if self.singer.song_tracker:has_song(partyMember:get_id(), song:get_spell().id, buffIds) then
            itemsToHighlight:append(IndexedItem.new(item, indexPath))
        end
        currentRow = currentRow + 1
    end
    itemsToAdd:append(IndexedItem.new(TextItem.new("", TextStyle.SingerView.Text), IndexPath.new(sectionNum, currentRow)))
    sectionNum = sectionNum + 1

    local songs = self.singer:get_songs()
    if songs:length() > 0 then
        itemsToAdd:append(IndexedItem.new(TextItem.new("Songs", TextStyle.Default.HeaderSmall), IndexPath.new(sectionNum, 1)))
        local currentRow = 2
        for song in songs:it() do
            local item = TextItem.new('• '..song:description(), TextStyle.SingerView.Text)
            local indexPath = IndexPath.new(sectionNum, currentRow)
            itemsToAdd:append(IndexedItem.new(item, indexPath))
            if self.singer.song_tracker:has_song(partyMember:get_id(), song:get_spell().id, buffIds) then
                itemsToHighlight:append(IndexedItem.new(item, indexPath))
            end
            currentRow = currentRow + 1
        end
    end

    self:getDataSource():addItems(itemsToAdd)

    for indexedItem in itemsToHighlight:it() do
        self:getDelegate():highlightItemAtIndexPath(indexedItem:getIndexPath())
    end

    self:setNeedsLayout()
    self:layoutIfNeeded()
end

function SingerView:onSelectMenuItemAtIndexPath(textItem, _)
    if textItem:getText() == 'Clear All' then
        self.singer.song_tracker:reset()
    end
end

return SingerView