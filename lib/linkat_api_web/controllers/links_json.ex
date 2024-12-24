defmodule LinkatApiWeb.LinksJSON do

  alias LinkatApi.CatPics.Client


  def create(%{link: link}) do
    %{
      success: true,
      message: "New link ready!",
      data: link
    }
  end

  def get(%{link: link}) do
    %{
      success: true,
      message: "Link found!",
      data: link,
      cat: Client.get_url()
    }
  end

end
