module ApplicationHelper
  def links_to_product(products)
    links =
      products.map do |product|
        link_to "#{product.name}", product_path(product.id)
      end
    links.flatten.join("<br>").html_safe
  end
end
