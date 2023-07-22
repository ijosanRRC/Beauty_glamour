ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :price, :description, :category_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :price, :description, :category_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :name, :description, :price

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :category
    column :image do |product|
      image_tag product.image.variant(resize: '100x100') if product.image.attached?
    end
    actions
  end

  form do |f|
    f.inputs 'Product Details' do
      f.input :name
      f.input :description
      f.input :price
      f.input :category
      f.input :image, as: :file
    end
    f.actions
  end

end
