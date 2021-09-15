# need to be edited
class RegisterController < ApplicationController

  # skip_before_action :authenticate, only: [:create]

  # def create
  #   email = params[:data][:attributes][:email].downcase
  #   user = User.find_or_initialize_by(email: email)

  #   return if conflicting_user?(user)

  #   user.assign_attributes create_params
  #   domain_value = email.split('@').last
  #   company_domain = CompanyDomain.find_by(domain: domain_value)
  #   user.company = company_domain&.company

  #   user.is_registered = true
  #   # users who have received a direct invite are auto-confirmed
  #   user.confirmed_at = Time.now if user.invites.exists?

  #   if company_domain
  #     if user.company.company_type.innovator?
  #       user.is_storefront_admin = true
  #     end

  #     if user.save
  #       notify_slack_successful_self_registration(user, company_domain)
  #       accept_contracts! user

  #       EmailConfirmationToken.new(user: user).save

  #       # if !user.company.try(:is_new_users_invited_to_series)
  #       #   user.service_line_ids = ServiceLine.joins(:membership_agreements).merge(user.company.membership_agreements.active).distinct.pluck(:id)
  #       # end

  #       if user.confirmed_at
  #         notify_slack_tawk_new_user_sign_in(user)
  #       else
  #         send_confirmation_email(user)
  #       end

  #       user.analytics_events.create!(
  #         event_type: 'create_account',
  #         origin_url: 'register',
  #         timestamp: Time.now
  #       )

  #       if user.company.is_storefront_published
  #         user.analytics_events.create!(
  #           event_type: 'innovator_request',
  #           origin_url: 'register',
  #           timestamp: Time.now
  #         )
  #       elsif user.company.contact_type == 'innovator'
  #         user.analytics_events.create!(
  #           event_type: 'storefront_request',
  #           origin_url: 'register',
  #           timestamp: Time.now
  #         )
  #       end

  #       if user.company.company_type.operator? && !user.company.active_membership_agreements.any?
  #         user.analytics_events.create!(
  #           event_type: 'bd_request',
  #           origin_url: 'register',
  #           timestamp: Time.now
  #         )
  #       end

  #       return render json: UserSerializer.new(user, {
  #         include: [:company]
  #       }).serializable_hash
  #     else
  #       data = { errors: [{ status: 400, code: 'BadRequest', detail: "There were issues with your registration data, please try again." }] }
  #       return render json: data, status: 400
  #     end
  #   else
  #     # Unknown user flow
  #     company_name = params[:data][:attributes][:company_name]
  #     company_type_id = 1 if params[:data][:attributes][:company_type] == 'operator'
  #     company_type_id = 2 if params[:data][:attributes][:company_type] == 'innovator'
  #     company_type_id = 4 if params[:data][:attributes][:company_type] == 'public'
  #     contact_type = 'innovator' if params[:data][:attributes][:company_type] == 'innovator'

  #     user.set_default_community

  #     if company_type_id == 2
  #       user.is_storefront_admin = true
  #     end

  #     user.company = Company.new(
  #       name: company_name,
  #       short_name: company_name,
  #       company_type_id: company_type_id,
  #       contact_type: contact_type,
  #       creator: user
  #     )
  #     user.company.company_domains.build(domain: domain_value)

  #     begin
  #       user.transaction do
  #         user.company.save!
  #         user.company.company_domains.first.save!
  #       end

  #       if user.save
  #         accept_contracts! user

  #         EmailConfirmationToken.new(user: user).save

  #         unless user.company.company_type.innovator?
  #           send_confirmation_email(user)
  #         end

  #         post_registration_message = post_registration_message(user.company)

  #         user.analytics_events.create!(
  #           event_type: 'create_account',
  #           origin_url: 'register',
  #           timestamp: Time.now
  #         )

  #         user.analytics_events.create!(
  #           event_type: 'unknown_company',
  #           origin_url: 'register',
  #           timestamp: Time.now
  #         )

  #         send_post_registration_email(user)
  #         notify_slack_post_registration(user)

  #         render json: UserSerializer.new(user, {
  #           include: %i[company],
  #           params: {
  #             post_registration_message: post_registration_message
  #           }
  #         }).serializable_hash
  #       else
  #         raise ActiveRecord::Rollback
  #         data = { errors: [{ status: 400, code: 'BadRequest', detail: "There were issues with your registration data, please try again." }] }
  #         render json: data, status: 400
  #       end
  #     rescue ActiveRecord::RecordInvalid
  #       data = { errors: [{ status: 400, code: 'BadRequest', detail: "There were issues with your registration data, please try again." }] }
  #       render json: data, status: 400
  #       raise ActiveRecord::Rollback
  #     end
  #   end
  # end

  # private

  # def send_confirmation_email(user)
  #   user.update(confirmation_sent_at: DateTime.now)
  # end

  # def send_post_registration_email(user)
  #   if user.company.blank?
  #     send_confirmation_email(user)
  #   elsif user.company.company_type.operator?
  #     if user.company.active_membership_agreements.any?
  #       send_confirmation_email(user)
  #     else
  #       send_access_request_next_steps_email(user)
  #     end
  #   end
  # end

  # def post_registration_message(company)
  #   message = 'Welcome to Darcy Connect, while your company is not an active member, our team will get in touch with you to discuss membership options. Until then, please enjoy our public content.'

  #   return message if company.blank?

  #   if company.company_type.operator? && company.active_membership_agreements.any?
  #     sponsor = company.sponsors.first
  #     message = "Your access request has been submitted for approval and will be reviewed by your company’s engagement manager #{sponsor&.email}"
  #   elsif company.company_type.innovator? && company.is_storefront_published
  #     message = "Thank you, Your storefront access request has been submitted to the Darcy Team for approval. Please confirm your email address and a Darcy representative will be in touch with you to help get you started."
  #   end

  #   message
  # end

  # def conflicting_user?(user)
  #   if user.is_registered
  #     data = { errors: [status: 409, code: 'Conflict', details: 'A user with this email already exists.'] }
  #     render json: data, status: :conflict and return true
  #   end
  # end

  # def notify_slack_successful_self_registration(user, company_domain)
  #   text = "User creation attempt: (success) domain: #{company_domain.domain} user: #{user.first_name} #{user.last_name} (#{user.email})"

  #   SlackService.new.send_with_metadata(text, {})
  # end

  # def notify_slack_post_registration(user)
  #   if user.company.blank?
  #     text = "Unknown Company registration for user: #{user.email}"
  #   elsif user.company.company_type.operator?
  #     if user.company.active_membership_agreements.any?
  #       text = "Access Request for user: #{user.email} (#{user.id}) at company: #{user.company.name} (#{user.company.id})"
  #     else
  #       text = "BD Access Request for user: #{user.email} (#{user.id}) at company: #{user.company.name} (#{user.company.id})"
  #     end
  #   elsif user.company.company_type.innovator?
  #     if user.company.is_storefront_published
  #       text = "Innovator Access Request for user: #{user.email} (#{user.id}) at company: #{user.company.name} (#{user.company.id})"
  #     else
  #       text = "Storefront Access Request for user: #{user.email} (#{user.id}) at company: #{user.company.name} (#{user.company.id})"
  #     end
  #   end

  #   SlackMessageJob.perform_later(text, {})
  # end

  # def notify_slack_failed_self_registration(user, company_domain)
  #   text = "User creation attempt: (failure) domain does not exist or allow_self_register is disabled for: #{user.first_name} #{user.last_name} (#{user.email})"

  #   SlackService.new.send_with_metadata(text, {})
  # end

  # def notify_slack_tawk_new_user_sign_in(user)
  #   text = "New user sign-in with confirmed email: #{user.first_name} #{user.last_name} (#{user.email})"
  #   channel = ENV['SLACK_TAWK_CHANNEL'] || 'opts-tawk'
  #   SlackService.new.send_with_metadata(text, {}, channel: channel)
  # end

  # def send_access_request_next_steps_email(user)
  #   AccessRequestNextStepsEmailJob.perform_later(user.id)
  # end

  # def send_next_steps_email(user)
  #   NextStepsEmailJob.perform_later(user.id)
  # end

  # def accept_contracts! user
  #   Contract.all.each do |contract|
  #     user.contract_acceptances.create(
  #       contract: contract,
  #       revision: contract.revisions.last
  #     )
  #   end
  # end

  # def create_params
  #   params[:data].require(:attributes).permit(
  #     :email,
  #     :first_name,
  #     :last_name,
  #     :title,
  #     :phone,
  #     :password
  #   )
  # end
end
