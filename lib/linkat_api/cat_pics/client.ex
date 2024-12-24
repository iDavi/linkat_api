defmodule LinkatApi.CatPics.Client do

    alias ExAws.S3

    @bucket_name "linkat-cdn-cats"
    @url_expire_time 5
    @rnd_gif_range 1..11

    def get_url do
        gif_path = "#{Enum.random(@rnd_gif_range)}.gif"
        generate_presigned_url(gif_path)
    end

    defp generate_presigned_url(object_key) do
      {:ok, url} =
        S3.presigned_url(
          ExAws.Config.new(:s3),
          :get,
          @bucket_name,
          object_key,
          expires_in: @url_expire_time
        )

      url
    end

end
