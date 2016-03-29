class Contact < MailForm::Base
  attribute :first_name,      :validate => true
  attribute :last_name,       :validate => true
  attribute :phone,           :validate => true
  attribute :email,           :validate => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i
  attribute :message

  # Declare the e-mail headers. It accepts anything the mail method
  # in ActionMailer accepts.
  def headers
    {
        :subject => "My Contact Form",
        :to => "bechirsegni@gmail.com",
        :from => %("#{first_name} #{last_name}" <#{email}>)
    }
  end
end