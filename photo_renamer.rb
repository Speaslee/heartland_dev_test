photo_names_string = "photo.jpg, Krakow, 2013-09-05 14:08:15
Mike.png, London, 2015-06-20 15:13:22
myFriends.png, Krakow, 2013-09-05 14:07:13
Eiffel.jpg, Florianopolis, 2015-07-23 08:03:02
pisatower.jpg, Florianopolis, 2015-07-22 23:59:59
BOB.jpg, London, 2015-08-05 00:02:03
notredame.png, Florianopolis, 2015-09-01 12:00:00
me.jpg, Krakow, 2013-09-06 15:40:22
a.png, Krakow, 2016-02-13 13:33:50
b.jpg, Krakow, 2016-01-02 15:12:22
c.jpg, Krakow, 2016-01-02 14:34:30
d.jpg, Krakow, 2016-01-02 15:15:01
e.png, Krakow, 2016-01-02 09:49:09
f.png, Krakow, 2016-01-02 10:55:32
g.jpg, Krakow, 2016-02-29 22:13:11"

def rename_photos(photo_names)
    photo_array = photo_names.split("\n")
    
    split_photo_array = []
    	photo_array.each_with_index do |photo_name, index|
    		photo = photo_name.split(", ")
    		new_photo = {"ext": photo[0].split(".")[1], "city": photo[1], "timestamp": photo[2], "position": index}
    		split_photo_array.push(new_photo)
    	end
    city_photo_hash = split_photo_array.group_by {|city| city[:city]}
    city_photo_hash.each do |city, photo_name|
        photo_name.sort_by! { |date_value| date_value[:timestamp]}
        if city == "Krakow"
            photo_name.each.with_index(1) do |photo, index|
                data_index = sprintf '%02d', index
                photo.merge!({"date_index": data_index}) 
            end
        else 
            photo_name.each.with_index(1) do |photo, index|
                photo.merge!({"date_index": index.to_s})
            end
        end
    
    end
    city_photos_array = city_photo_hash.values.flatten
    city_photos_array.sort_by! { |position_value| position_value[:position]}
    new_photo_names = []
    city_photos_array.each do |photo|
        new_photo_name = "#{photo[:city]}#{photo[:date_index]}.#{photo[:ext]}"
        new_photo_names.push(new_photo_name)
    end
    puts new_photo_names
end

rename_photos photo_names_string

