# frozen_string_literal: true

RSpec.describe NMax::Number do
  describe '.new' do
    subject(:result) { described_class.new(str, zeroes) }

    describe 'result' do
      subject { result }

      let(:str) { '123' }
      let(:zeroes) { 0 }

      it { is_expected.to be_a(described_class) }
    end

    context 'when `str` argument is not of `String` class' do
      let(:str) { 123 }
      let(:zeroes) { 0 }

      it 'should raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when `str` argument starts with `0` digit' do
      let(:str) { '0123' }
      let(:zeroes) { 0 }

      it 'should raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when `zeroes` argument is not of `Integer` class' do
      let(:str) { '123' }
      let(:zeroes) { 'not of `Integer` class' }

      it 'should raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when `zeroes` argument is negative' do
      let(:str) { '123' }
      let(:zeroes) { -1 }

      it 'should raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when the resulting number has too many digits' do
      let(:str) { '123' }
      let(:zeroes) { described_class::MAX_LENGTH }

      it 'should raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'instance' do
    subject { described_class.new(str, zeroes) }

    let(:str) { '123' }
    let(:zeroes) { 0 }

    it { is_expected.to respond_to(:<=>, :to_s) }
  end

  describe '#<=>' do
    subject(:result) { instance.<=>(arg) }

    let(:instance) { described_class.new(str, zeroes) }
    let(:str) { '123' }
    let(:zeroes) { 0 }

    describe 'result' do
      subject { result }

      let(:arg) { Struct.new(:num).new(num) }

      context 'when argument\'s #num property is not of `Integer` class' do
        let(:num) { 'something not of `Integer` class' }

        it { is_expected.to be_nil }
      end

      context 'when argument\'s #num property is of `Integer` class' do
        let(:num) { 456 }

        it { is_expected.to be_an(Integer) }

        it 'should be a result of comparison of the number to the property' do
          expect(subject).to be == (str.to_i <=> num)
        end
      end

      context 'when argument is of the same class' do
        let(:arg) { described_class.new(str2, zeroes2) }
        let(:str2) { '456' }
        let(:zeroes2) { 1 }

        it 'should be a result of comparison of the numbers' do
          expect(subject).to be == (str.to_i <=> str2.to_i)
        end
      end
    end

    context 'when argument doesn\'t provide #num method' do
      let(:arg) { Object.new }

      it 'should raise NoMethodError' do
        expect { subject }.to raise_error(NoMethodError)
      end
    end
  end

  describe '#to_s' do
    subject(:result) { instance.to_s }

    let(:instance) { described_class.new(str, zeroes) }
    let(:str) { '123' }
    let(:zeroes) { 10 }

    describe 'result' do
      subject { result }

      it { is_expected.to be_a(String) }

      it 'should be a string representation of the number' do
        expect(result.to_i).to be == str.to_i
      end

      it 'should include all leading zeroes' do
        expect(result).to be_start_with('0' * zeroes)
      end
    end
  end
end
