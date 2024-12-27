defmodule LinkatApiWeb.LinksJSON do


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
