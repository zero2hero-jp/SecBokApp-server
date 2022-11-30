class SheetSerializer < ActiveModel::Serializer
  attributes :id
  attributes :email
  attributes :spreadsheet_id
  attributes :created_at
  attributes :updated_at
end
