class AddBigbluebuttonRoomToCourse < ActiveRecord::Migration[5.1]
  def change
    add_reference :courses, :bigbluebutton_room, foreign_key: true
  end
end
