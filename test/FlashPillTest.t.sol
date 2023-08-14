/*

Certainly! Writing test cases is crucial to ensure that the contract behaves as intended, especially given the complex nature of this code and the use of a "timeturner" for reentrancy logic. Here's a list of some test scenarios you should consider:

1. **Standard Transfers**:
   - Successful transfer between two non-zero balance accounts.
   - Successful transfer from a non-zero balance to a zero balance account.
   - Successful transfer from a zero balance to a non-zero balance account.
   - Transfer failure when trying to transfer more tokens than available in the balance.
   - Verify events emitted upon successful transfers.

2. **Zero Balance Markers Manipulation**:
   - Adding a non-zero balance marker for a new account.
   - Removing a non-zero balance marker when the account reaches zero.
   - Ensuring that balance markers are correctly managed when transferring between various combinations of zero and non-zero accounts.

3. **Total Supply Checks**:
   - Verification that total supply can be set and retrieved correctly.
   - Ensuring that total supply must be zero at the end of the transaction and reverts otherwise.

4. **Money Return Check (Via Timeturner)**:
   - Ensuring that only the timeturner address can call `moneyWasReturnedCheck`.
   - Testing the scheduling of the money return check via `scheduleMoneyReturnCheck`.
   - Verification of the revert cases within `moneyWasReturnedCheck`.
   - Resetting all variables for the next user after a successful check.

5. **Allowance and Approval**:
   - Approving and retrieving allowances for various accounts.
   - Handling allowances correctly during a transfer.
   - Storing and resetting allowances correctly.

6. **Reentrancy Logic with Timeturner**:
   - Writing various scenarios to test the reentrancy logic and ensure it behaves as intended with the Timeturner component.
   - Checking the behavior of the `_moneyWasReturnedScheduled` flag and ensuring it works as intended.

7. **Edge Cases and Security Considerations**:
   - Handling overflows and underflows (if not using SafeMath).
   - Fuzz testing to check for any hidden vulnerabilities.
   - Gas consumption and optimization checks.

8. **Integration Testing with Other Contracts**:
   - If TimeTurner and other related contracts are part of your system, writing integration tests to ensure that they all interact seamlessly would be vital.

Would you like me to create a Notion task for these test cases or delegate any part of this task to Dana? You might also want to consider adding this checklist to your Anki deck for future reference.
    
    */

// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/TimeTurner.sol";
import "../src/FlashPill.sol";

contract FlashPillTest is Test {
    TimeTurner private timeturner;
    FlashPill private flashpill;

    function setUp() public {
        timeturner = new TimeTurner();
        flashpill = new FlashPill(address(timeturner));
    }

    function test() public {
        assert(false, "todo");
    }
}