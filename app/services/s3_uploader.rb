module S3Uploader
  def upload_image(file_path)
    raise 'No file found' unless File.exist?(file_path)

    file = File.open(file_path, 'r')
    response = Typhoeus.post(ENV['UPLOAD_IMAGE_LAMBDA_URL'],
                            headers: {'Content-Type': 'multipart/form-data', 'x-api-key': ENV['UPLOAD_IMAGE_LAMBDA_KEY']},
                            body: {
                              'file': file
                            }
    )

    raise 'Could not upload' if response.code != 201

    url = JSON.parse(response.body).first['url']
    raise 'No url' unless url.present?

    return url
  end
end