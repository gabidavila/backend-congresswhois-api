module ProPublica
  module Congress
    def self.base_url
      Rails.application.config.propublica[:api_base_url]
    end

    def self.key
      Rails.application.config.propublica[:api_key]
    end

    class Member
      def self.fetch(id)
        member       = CongressMember.find_by(id: id)
        url          = member.general_response_api["api_uri"]
        rest_options = {
          method:  :get,
          url:     url,
          headers: { "X-API-Key": Congress.key }
        }
        response     = RestClient::Request.execute(rest_options)
        JSON.parse(response.body)
      end
    end

    class Parties
      def self.state_representation
        url          = "#{Congress.base_url}/states/members/party.json"
        rest_options = {
          method:  :get,
          url:     url,
          headers: { "X-API-Key": Congress.key }
        }
        response     = RestClient::Request.execute(rest_options)
        JSON.parse(response.body)['results']
      end
    end

    class Senate
      def self.current
        Rails.application.config.propublica[:congress][:current_senate]
      end

      def self.members
        url      = "#{Congress.base_url}/#{current}/senate/members.json"
        response = RestClient::Request.execute(method: :get, url: url, headers: { "X-API-Key": Congress.key })
        JSON.parse(response.body)['results'].first['members']
      end
    end

    class House
      def self.current
        Rails.application.config.propublica[:congress][:current_house]
      end

      def self.members
        url          = "#{Congress.base_url}/#{current}/house/members.json"
        rest_options = {
          method:  :get,
          url:     url,
          headers: { "X-API-Key": Congress.key }
        }
        response     = RestClient::Request.execute(rest_options)
        JSON.parse(response.body)['results'].first['members']
      end
    end
  end
end
