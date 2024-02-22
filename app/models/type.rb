class Type < ActiveHash::Base
  self.data = [
    { id: 1, name: '種別を選択してください (必須)' },
    { id: 2, name: '予定' },
    { id: 3, name: 'タスク' },
    { id: 4, name: '日記' }
  ]

  include ActiveHash::Associations
  has_many :posts
end