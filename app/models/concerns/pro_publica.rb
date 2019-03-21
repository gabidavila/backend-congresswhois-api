module ProPublica
  module Congress
    def self.base_url
      Rails.application.config.propublica[:api_base_url]
    end

    def self.current
      Rails.application.config.propublica[:congress][:current_senate]
    end

    def self.fetch(url)
      rest_options = {
        method:  :get,
        url:     url,
        headers: { "X-API-Key": Rails.application.config.propublica[:api_key] }
      }
      JSON.parse(RestClient::Request.execute(rest_options).body)
    end

    class Bills
      def self.recent(offset = 0)
        url = "#{Congress.base_url}/#{Congress.current}/both/bills/introduced.json?offset=#{offset}"
        Congress.fetch(url)
      end
    end

    class Member
      def self.fetch(id)
        member = CongressMember.find_by(id: id)
        url    = member.general_response_api["api_uri"]
        Congress.fetch(url)
      end
    end

    class Parties
      def self.state_representation
        url = "#{Congress.base_url}/states/members/party.json"
        Congress.fetch(url)['results']
      end
    end

    class Senate
      def self.members(congress_number)
        congress_number = congress_number || Congress.current
        url = "#{Congress.base_url}/#{congress_number}/senate/members.json"
        Congress.fetch(url)['results'].first['members']
      end
    end

    class House
      def self.members(congress_number)
        congress_number = congress_number || Congress.current
        url = "#{Congress.base_url}/#{congress_number}/house/members.json"
        Congress.fetch(url)['results'].first['members']
      end
    end

    class Comparisons
      def self.votes(request)
        url = "#{Congress.base_url}/members/#{request[:member_id1]}/votes/#{request[:member_id2]}/#{request[:congress]}/#{request[:chamber]}.json"
        Congress.fetch(url)['results'].first
      end

      def self.bills(request)
        url = "#{Congress.base_url}/members/#{request[:member_id1]}/bills/#{request[:member_id2]}/#{request[:congress]}/#{request[:chamber]}.json"
        Congress.fetch(url)['results'].first
      end
    end
  end
end
