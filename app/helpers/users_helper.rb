module UsersHelper
  def birthday(user)
    if user.date_of_birth
      user.date_of_birth.strftime("%d.%m.%Y")
    else
      ''
    end
  end
end