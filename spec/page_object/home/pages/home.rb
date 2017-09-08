module Home
  class Index < SitePrism::Page
    set_url "/"

    element :login_button,  ".btn.btn-success"
  end

  class Edit < SitePrism::Page
    set_url "/"

    element :login_button,  ".btn.btn-success"
  end
end