require_relative './../../spec_helper.rb'


describe FaqModule::RemoveService do
  describe '#call' do
    context "Valid ID" do
      before do
        faq = create(:faq)
        @removeService = FaqModule::RemoveService.new({"id" => faq.id})
      end

      it "Return success message" do
        response = @removeService.call()
        expect(response).to match("Deletado com sucesso")
      end

      it "Remove Faq from database" do
        expect(Faq.all.count).to eq(1)
        response = @removeService.call()
        expect(Faq.all.count).to eq(0)
      end
    end

    context "Invalid ID" do
      it "return error message" do
        @removeService = FaqModule::RemoveService.new({"id" => rand(1..9999)})
        response = @removeService.call()
  
        expect(response).to match("Questão inválida, verifique o Id")
      end
    end
  end
end