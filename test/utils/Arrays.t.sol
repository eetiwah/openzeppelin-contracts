// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Test} from "../../../forge-std/src/Test.sol";
import {SymTest} from "../../../halmos-cheatcodes/src/SymTest.sol";
import {Arrays} from "../../contracts/utils/Arrays.sol";

contract ArraysTest is Test, SymTest {
    function testSort(uint256[] memory values) public {
        Arrays.sort(values);
        _assertSort(values);
    }

    function symbolicSort() public {
        uint256[] memory values = new uint256[](3);
        for (uint256 i = 0; i < 3; i++) {
            values[i] = svm.createUint256("arrayElement");
        }
        Arrays.sort(values);
        _assertSort(values);
    }

    /// Asserts

    function _assertSort(uint256[] memory values) internal {
        for (uint256 i = 1; i < values.length; ++i) {
            assertLe(values[i - 1], values[i]);
        }
    }
}
