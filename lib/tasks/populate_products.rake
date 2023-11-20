namespace :products do
desc "Populate products from JSON file"

  task populate: :environment do
    file_path = 'products.json' # Update this with the actual path
    ImportProducts.import_from_json(file_path)
  end
end