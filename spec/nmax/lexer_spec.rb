# frozen_string_literal: true

RSpec.describe NMax::Lexer do
  describe 'the class' do
    subject { described_class }

    it { is_expected.to respond_to(:new) }
  end

  describe '.new' do
    subject(:result) { described_class.new }

    describe 'result' do
      subject { result }

      it { is_expected.to be_an_instance_of(described_class) }
    end
  end

  describe 'instance' do
    subject { described_class.new }

    it { is_expected.to respond_to(:feed) }
  end

  describe '#feed' do
    subject(:result) { instance.feed(code) }

    let(:instance) { described_class.new }

    describe 'result' do
      subject { result }

      context 'when the code is ASCII code of a digit' do
        let(:code) { 50 }

        context 'when stored number is long enough' do
          before { NMax::Number::MAX_LENGTH.pred.times { instance.feed(48) } }

          it { is_expected.to be_a(NMax::Number) }

          it 'should be the number' do
            expect(result.to_s)
              .to be == '0' * NMax::Number::MAX_LENGTH.pred + '2'
          end
        end

        context 'when stored number isn\'t long enough' do
          it { is_expected.to be_nil }
        end
      end

      context 'when the code is not ASCII code if a digit' do
        let(:code) { 'not ASCII code if a digit' }

        context 'when there is stored number' do
          before { NMax::Number::MAX_LENGTH.pred.times { instance.feed(48) } }

          it { is_expected.to be_a(NMax::Number) }

          it 'should be the number' do
            expect(result.to_s).to be == '0' * NMax::Number::MAX_LENGTH.pred
          end
        end

        context 'when there is no stored number' do
          it { is_expected.to be_nil }
        end
      end
    end
  end
end
