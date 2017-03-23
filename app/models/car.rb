class Car < ApplicationRecord
  has_many :car_rentals, dependent: :destroy
  validates :name, presence: true

  class << self
    def create(data, rental_data)
      car = Car.new
      car.name = extract_name(rental_data)
      car.category = extract_category(data, rental_data)
      car.doors = rental_data['doors']
      car.seats = rental_data['seats']
      car.image_url = extract_image_url(data, rental_data)
      car.save
      car
    end

    def extract_category(data, rental_data)
      id = rental_data['car_class_id']
      category = data['car_classes'].select { |car_class|
        car_class['id'] == id
      }
      if category == []
        "unknown"
      else
        category.first['name']
      end
    end

    def extract_name(rental_data)
      if rental_data['vehicle'] == nil
        "Unknown car"
      else
        rental_data['vehicle'].gsub(" or similar", "")
      end
    end

    def extract_image_url(data, rental_data)
      image_id = rental_data['image_id']
      image_urls = data['images'].select{ |image|
        image['id'] == image_id
      }
      image_url = image_urls.first['url'] unless image_urls == []
    end

  end
end