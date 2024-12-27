defmodule LinkatApiWeb.LinksJSON do

  alias LinkatApi.CatPics.Client


  def create(%{link: link}) do
    %{
      data: link
    }
  end

  def get(%{link: link}) do
    %{
      data: link
    }
  end

end
