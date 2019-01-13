# frozen_string_literal: true

RSpec.describe NMax::Application do
  describe 'the class' do
    subject { described_class }

    it { is_expected.to respond_to(:new) }
  end

  describe '.new' do
    subject(:result) { described_class.new(io, capacity) }

    let(:io) { nil }
    let(:capacity) { nil }

    it 'should try to create a lexer' do
      expect(NMax::Lexer).to receive(:new)
      subject
    end

    it 'should try to create a filter' do
      expect(NMax::Filter).to receive(:new)
      subject
    end

    describe 'result' do
      subject { result }

      it { is_expected.to be_an_instance_of(described_class) }
    end

    context 'when `capacity` argument can\'t be coalesced to integer' do
      let(:capacity) { 'can\'t be coalesced to integer' }

      it 'should create a filter with default capacity' do
        expect(NMax::Filter)
          .to receive(:new)
          .with(capacity.to_i)
          .and_call_original
        expect(NMax::Filter)
          .to receive(:new)
          .with(described_class::DEFAULT_CAPACITY)
          .and_call_original
        subject
      end
    end

    context 'when `capacity` argument is coalescing to a negative integer' do
      let(:capacity) { '-1' }

      it 'should create a filter with default capacity' do
        expect(NMax::Filter)
          .to receive(:new)
          .with(capacity.to_i)
          .and_call_original
        expect(NMax::Filter)
          .to receive(:new)
          .with(described_class::DEFAULT_CAPACITY)
          .and_call_original
        subject
      end
    end

    context 'when `capacity` argument is coalescing to zero' do
      let(:capacity) { 0.0 }

      it 'should create a filter with default capacity' do
        expect(NMax::Filter)
          .to receive(:new)
          .with(capacity.to_i)
          .and_call_original
        expect(NMax::Filter)
          .to receive(:new)
          .with(described_class::DEFAULT_CAPACITY)
          .and_call_original
        subject
      end
    end

    context 'when `capacity` argument is coalescing to a positive integer' do
      let(:capacity) { 110.9 }

      it 'should create a filter with the value coalesced to the integer' do
        expect(NMax::Filter)
          .to receive(:new)
          .with(capacity.to_i)
          .and_call_original
        subject
      end
    end
  end

  describe 'instance' do
    subject { described_class.new(io, capacity) }

    let(:io) { nil }
    let(:capacity) { nil }

    it { is_expected.to respond_to(:run!) }
  end

  describe '#run!' do
    subject { instance.run! }

    let(:instance) { described_class.new(io, capacity) }
    let(:capacity) { 2 }

    context 'when `io` argument doesn\'t have `#getbyte` method' do
      let(:io) { nil }

      it 'should raise NoMethodError' do
        expect { subject }.to raise_error(NoMethodError)
      end
    end

    context 'when `io` argument has `#getbyte` method' do
      before { allow(instance).to receive(:puts) }

      let(:io) { StringIO.new("123\n0456\nfgfgfd\t00034") }

      it 'should call the method til it returns `nil`' do
        expect(io)
          .to receive(:getbyte)
          .exactly(io.string.size + 1)
          .times
          .and_call_original
        subject
      end

      it 'should write lines to output stream no more than capacity times' do
        expect(instance).to receive(:puts).at_most(capacity).times
        subject
      end

      it 'should output greatest numbers in ascension order' do
        expect(instance).to receive(:puts).with(NMax::Number.new('123', 0))
        expect(instance).to receive(:puts).with(NMax::Number.new('456', 1))
        subject
      end
    end
  end
end
