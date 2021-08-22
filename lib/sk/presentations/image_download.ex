defmodule Sk.Presentations.ImageDownload do
  # TODO: Make this a behavior, for testing
  alias HTTPoison.Response

  def download_body(url) do
    case HTTPoison.get(url, follow_redirect: true) do
      # Would be nice to capture Content-Type response header if present.
      {:ok, %Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %Response{status_code: sc}} -> {:error, sc}
      {:error, reason} -> {:error, reason}
    end
  end

  @spec download(url::String.t) ::
  {:ok, width::non_neg_integer(), height::non_neg_integer(), mime_type::String.t, image_data::binary()} |
  {:error, reason::term()}
  def download(url) do
    case download_body(url) do
      {:ok, body} -> {:ok, 0, 0, "", body}

    end


  end
end
