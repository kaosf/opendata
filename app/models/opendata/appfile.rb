class Opendata::Appfile
  include SS::Document
  include SS::Relation::File

  seqid :id
  field :name, type: String
  field :filename, type: String
  field :text, type: String

  embedded_in :app, class_name: "Opendata::App", inverse_of: :appfile
  belongs_to_file :file

  permit_params :name, :text

  validates :name, presence: true
  validates :in_file, presence: true, if: ->{ file_id.blank? }

  before_validation :set_filename, if: ->{ in_file.present? }

  after_save -> { app.save(validate: false) }
  after_destroy -> { app.save(validate: false) }

  public
    def url
      app.url.sub(/\.html$/, "") + "/appfile/#{id}/#{filename}"
    end

    def full_url
      app.full_url.sub(/\.html$/, "") + "/appfile/#{id}/#{filename}"
    end

    def path
      file ? file.path : nil
    end

    def content_type
      file ? file.content_type : nil
    end

    def size
      file ? file.size : nil
    end

    def allowed?(action, user, opts = {})
      true
    end

  private
    def set_filename
      self.filename = in_file.original_filename
    end

  class << self
    public
      def allowed?(action, user, opts = {})
        true
      end

      def allow(action, user, opts = {})
        true
      end

      def search(params)
        criteria = self.where({})
        return criteria if params.blank?

        criteria = criteria.where(name: /#{params[:keyword]}/) if params[:keyword].present?

        criteria
      end
  end
end