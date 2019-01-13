# frozen_string_literal: true

RSpec.describe NMax::Filter do
  describe 'the class' do
    subject { described_class }

    it { is_expected.to respond_to(:new) }
  end

  describe '.new' do
    subject(:result) { described_class.new(capacity) }

    describe 'result' do
      subject { result }

      let(:capacity) { 10 }

      it { is_expected.to be_a(described_class) }
    end

    context 'when `capacity` argument is not of `Integer` class' do
      let(:capacity) { 'not of `Integer` class' }

      it 'should raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when `capacity` argument is negative' do
      let(:capacity) { -1 }

      it 'should raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when `capacity` argument is zero' do
      let(:capacity) { 0 }

      it 'should raise ArgumentError' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end

  describe 'instance' do
    subject { described_class.new(capacity) }

    let(:capacity) { 10 }

    it { is_expected.to respond_to(:each, :push) }

    it 'should be enumerable' do
      expect(subject).to be_an(Enumerable)
    end
  end

  describe '#each' do
    before { items.each(&instance.method(:push)) }

    let(:instance) { described_class.new(capacity) }
    let(:capacity) { 3 }
    let(:items) { [1, 4, 3, 2, 5] }

    context 'when a block is given' do
      subject(:result) { instance.each {} }

      it 'should yield no more items than the capacity allows' do
        expect { |b| subject.each(&b) }
          .to yield_control.at_most(capacity).times
      end

      it 'should yield greatest items in ascension order' do
        expect { |b| subject.each(&b) }
          .to yield_successive_args(*items.sort.last(capacity))
      end

      describe 'result' do
        subject { result }

        it 'should be the instance' do
          expect(subject).to be == instance
        end
      end
    end

    context 'when no block is given' do
      subject(:result) { instance.each }

      describe 'result' do
        subject { result }

        it { is_expected.to be_an(Enumerator) }

        it 'should enumerate no more items than the capacity allows' do
          expect { |b| subject.each(&b) }
            .to yield_control.at_most(capacity).times
        end

        it 'should enumerate greatest items in ascension order' do
          expect { |b| subject.each(&b) }
            .to yield_successive_args(*items.sort.last(capacity))
        end
      end
    end
  end

  describe '#push' do
    subject { instance.push(value) }

    let(:instance) { described_class.new(capacity) }
    let(:capacity) { 3 }

    context 'when the instance is not full' do
      let(:value) { 1 }

      it 'should add the argument to items' do
        expect { subject }.to change { instance.to_a }.from([]).to([value])
      end
    end

    context 'when the instance is full' do
      before { items.each(&instance.method(:push)) }

      let(:items) { [1, 2, 4] }

      context 'when the argument is less than current minimum item' do
        let(:value) { items.min - 1 }

        it 'shouldn\'t add the argument to items' do
          expect { subject }.not_to change { instance.to_a }
        end
      end

      context 'when the argument is equal to current minimum item' do
        let(:value) { items.min }

        it 'shouldn\'t add the argument to items' do
          expect { subject }.not_to change { instance.to_a }
        end
      end

      context 'when the argument is more than current minimum item' do
        context 'when it equals to an other item' do
          let(:value) { items.max }

          it 'shouldn\'t add the argument to items' do
            expect { subject }.not_to change { instance.to_a }
          end
        end

        context 'when it doesn\'t equal to any other item' do
          let(:value) { items.max + 1 }

          it 'should remove minimum item and add the argument to items' do
            expect { subject }
              .to change { instance.to_a }
              .to(items[1..-1] + [value])
          end
        end
      end
    end
  end
end
