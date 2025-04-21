module FacultiesHelper
  def remote_sort_link(search_object, attribute, label = nil)
    # Копируем текущие параметры фильтра
    q_params = (params[:q]&.to_unsafe_h || {}).dup

    # Добавляем/обновляем параметр сортировки
    q_params["s"] = "#{attribute} #{toggle_sort_direction(search_object, attribute)}"

    # Собираем общий список параметров
    full_params = request.query_parameters.deep_dup
    full_params[:q] = q_params

    # Строим ссылку с remote: true
    link_to(label || attribute.to_s.humanize, url_for(params: full_params), remote: true)
  end

  def toggle_sort_direction(search_object, attribute)
    current_sort = Array(search_object.sorts).find { |s| s.name == attribute.to_s }
    current_sort&.dir == "asc" ? "desc" : "asc"
  end
end
