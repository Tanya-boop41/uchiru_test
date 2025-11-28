module ResponseHandler
  extend ActiveSupport::Concern

  private

  def render_not_found
    render json: { error: "Not found" }, status: :not_found
  end

  def render_success(data:, status: :ok, serializer: nil, params: {})
  if serializer
    serialized_data = serializer.new(data, params:).serializable_hash[:data]

    serialized_attributes =
      if serialized_data.is_a?(Array)
        serialized_data.map { |item| item[:attributes] }
      else
        serialized_data[:attributes]
      end

    render json: { data: serialized_attributes }.compact, status: status
  else
    render json: data, status: status
  end
end

  def render_unauthorized(message = "Not authorized")
    render json: { error: message }, status: :unauthorized
  end
end
