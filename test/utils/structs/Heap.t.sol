// SPDX-License-Identifier: MIT
// This file was procedurally generated from scripts/generate/templates/Heap.t.js.

pragma solidity ^0.8.20;

import {Test} from "../../../../forge-std/src/Test.sol";
import {Math} from "../../../contracts/utils/math/Math.sol";
import {Heap} from "../../../contracts/utils/structs/Heap.sol";
import {Comparators} from "../../../contracts/utils/Comparators.sol";

contract Uint256HeapTest is Test {
    using Heap for Heap.Uint256Heap;

    Heap.Uint256Heap internal heap;

    function _validateHeap(function(uint256, uint256) view returns (bool) comp) internal {
        for (uint32 i = 0; i < heap.length(); ++i) {
            // lookups
            assertEq(i, heap.data[heap.data[i].index].lookup);
            assertEq(i, heap.data[heap.data[i].lookup].index);

            // ordering: each node has a value bigger then its parent
            if (i > 0)
                assertFalse(comp(heap.data[heap.data[i].index].value, heap.data[heap.data[(i - 1) / 2].index].value));
        }
    }

    function testFuzz(uint256[] calldata input) public {
        vm.assume(input.length < 0x20);
        assertEq(heap.length(), 0);

        uint256 min = type(uint256).max;
        for (uint256 i = 0; i < input.length; ++i) {
            heap.insert(input[i]);
            assertEq(heap.length(), i + 1);
            _validateHeap(Comparators.lt);

            min = Math.min(min, input[i]);
            assertEq(heap.peek(), min);
        }

        uint256 max = 0;
        for (uint256 i = 0; i < input.length; ++i) {
            uint256 top = heap.peek();
            uint256 pop = heap.pop();
            assertEq(heap.length(), input.length - i - 1);
            _validateHeap(Comparators.lt);

            assertEq(pop, top);
            assertGe(pop, max);
            max = pop;
        }
    }

    function testFuzzGt(uint256[] calldata input) public {
        vm.assume(input.length < 0x20);
        assertEq(heap.length(), 0);

        uint256 max = 0;
        for (uint256 i = 0; i < input.length; ++i) {
            heap.insert(input[i], Comparators.gt);
            assertEq(heap.length(), i + 1);
            _validateHeap(Comparators.gt);

            max = Math.max(max, input[i]);
            assertEq(heap.peek(), max);
        }

        uint256 min = type(uint256).max;
        for (uint256 i = 0; i < input.length; ++i) {
            uint256 top = heap.peek();
            uint256 pop = heap.pop(Comparators.gt);
            assertEq(heap.length(), input.length - i - 1);
            _validateHeap(Comparators.gt);

            assertEq(pop, top);
            assertLe(pop, min);
            min = pop;
        }
    }
}

contract Uint208HeapTest is Test {
    using Heap for Heap.Uint208Heap;

    Heap.Uint208Heap internal heap;

    function _validateHeap(function(uint256, uint256) view returns (bool) comp) internal {
        for (uint32 i = 0; i < heap.length(); ++i) {
            // lookups
            assertEq(i, heap.data[heap.data[i].index].lookup);
            assertEq(i, heap.data[heap.data[i].lookup].index);

            // ordering: each node has a value bigger then its parent
            if (i > 0)
                assertFalse(comp(heap.data[heap.data[i].index].value, heap.data[heap.data[(i - 1) / 2].index].value));
        }
    }

    function testFuzz(uint208[] calldata input) public {
        vm.assume(input.length < 0x20);
        assertEq(heap.length(), 0);

        uint256 min = type(uint256).max;
        for (uint256 i = 0; i < input.length; ++i) {
            heap.insert(input[i]);
            assertEq(heap.length(), i + 1);
            _validateHeap(Comparators.lt);

            min = Math.min(min, input[i]);
            assertEq(heap.peek(), min);
        }

        uint256 max = 0;
        for (uint256 i = 0; i < input.length; ++i) {
            uint208 top = heap.peek();
            uint208 pop = heap.pop();
            assertEq(heap.length(), input.length - i - 1);
            _validateHeap(Comparators.lt);

            assertEq(pop, top);
            assertGe(pop, max);
            max = pop;
        }
    }

    function testFuzzGt(uint208[] calldata input) public {
        vm.assume(input.length < 0x20);
        assertEq(heap.length(), 0);

        uint256 max = 0;
        for (uint256 i = 0; i < input.length; ++i) {
            heap.insert(input[i], Comparators.gt);
            assertEq(heap.length(), i + 1);
            _validateHeap(Comparators.gt);

            max = Math.max(max, input[i]);
            assertEq(heap.peek(), max);
        }

        uint256 min = type(uint256).max;
        for (uint256 i = 0; i < input.length; ++i) {
            uint208 top = heap.peek();
            uint208 pop = heap.pop(Comparators.gt);
            assertEq(heap.length(), input.length - i - 1);
            _validateHeap(Comparators.gt);

            assertEq(pop, top);
            assertLe(pop, min);
            min = pop;
        }
    }
}
