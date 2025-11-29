module ResponseHandler
  extend ActiveSupport::Concern

  private

  def render_not_found
    render json: { error: "Not found" }, status: :not_found
  end

  def render_success(data:, status: :ok, serializer: nil, params: {})
  if serializer
    serialized = serializer.new(data, params:).serializable_hash[:data]

    data =
      if serialized.is_a?(Array)
        serialized.map { |item| item[:attributes] }
      else
        serialized[:attributes]
      end

    render json: { data: }.compact, status:
  else
    render json: data, status:
  end
end

  def render_unauthorized(message = "Not authorized")
    render json: { error: message }, status: :unauthorized
  end
end
