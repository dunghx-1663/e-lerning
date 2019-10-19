module ApplicationHelper

  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to(name, onclick: "remove_fields(this)")
  end

  def link_to_add_fields name, f, association, opts={}
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
  end
   link_to name, "javascript:void(0)", onclick: "add_fields(this,\"#{association}\",
    \"#{j(fields)}\")", class: "btn btn-primary"
  end

  def create_index params_page, index, per
    params_page = 1 if params_page.nil?
    (params_page.to_i - 1) * per.to_i + index.to_i + 1
  end
end
