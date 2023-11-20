module ImportProducts
  require 'json'

  def self.import_from_json(file_path)
    file = File.read(file_path)
    data = JSON.parse(file)

    # Iterate over each product and create records
    data['products'].each do |product_data|
      Product.create!(
        name: product_data['name'],
        type: product_data['type'],
        length: product_data['length'],
        width: product_data['width'],
        height: product_data['height'],
        weight: product_data['weight']
      )
    end
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
  end
end