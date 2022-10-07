class Firestore
  require 'google/cloud/storage'

  storage = Google::Cloud::Storage.new(
    project_id: ENV['GCS_PROJECT_ID'],
    credentials: "gcs_key.json"
  )
  @@bucket = storage.bucket ENV['GCS_BUCKET']

  def self.add_image_from_base64(base64, subscription_id)
    image_match = base64.match(/^data:(.*?);(?:.*?),(.*)$/)
    mime_type, encoded_image = image_match.captures
    extension = mime_type.split('/').second
    decoded_image = Base64.decode64(encoded_image)
    path = "subscriptions/images/#{subscription_id}.#{extension}"
    data = StringIO.new decoded_image
    @@bucket.create_file(data, path)
    return path
  end

  def self.get_image_url(path)
    file = @@bucket.file(path)
    if !file.nil?
      file.signed_url(method: "GET", expires: 60 * 60 * 24 * 365)
    else
      nil
    end
  end

  def self.save_image_and_get_url(base64, subscription_id)
    path = add_image_from_base64(base64, '12')
    return get_image_url(path)
  end

end
