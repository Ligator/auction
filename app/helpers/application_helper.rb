module ApplicationHelper
  def links_to_product(products)
    links =
      products.map do |product|
        link_to "#{product.name}", product_path(product.id)
      end
    links.flatten.join("<br>").html_safe
  end

  def user_contact(user)
    contact = ""
    contact += "<p>#{user.email}</p>"
    contact += "<p>#{user.phone}</p>"
    contact.html_safe
  end
end
