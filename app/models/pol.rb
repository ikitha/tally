class Pol < ActiveRecord::Base
	has_many :events
	has_many :comments, as: :commentable
	has_many :favorites, as: :favorited
	has_many :pac_pols, dependent: :destroy
  has_many :pacs, through: :pac_pols
	# def fullname
	# 	"#{firstname} #{lastname}"
	# end

	before_save :make_fullname
	# before_create :set_auth_token

	def make_fullname
		self.fullname = "#{firstname} #{lastname}"
	end

	private

		def set_auth_token
			return if auth_token.present?
			self.auth_token = generate_auth_token
		end

		def generate_auth_token
			loop do
				token = SecureRandom.hex
				break token unless self.class.exists?(auth_token: token)
			end
		end

end
