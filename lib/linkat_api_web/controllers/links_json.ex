defmodule LinkatApiWeb.LinksJSON do
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
      data: link
    }
  end

end
