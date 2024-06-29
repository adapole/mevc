// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@eigenlayer/contracts/libraries/BytesLib.sol";
import "./IBorrowableEVCVault.sol";
import "@eigenlayer-middleware/src/ServiceManagerBase.sol";

contract BorrowableEVCServiceManager is ServiceManagerBase {
    using BytesLib for bytes;

    IBorrowableEVCVault public immutable borrowableEVCVaultTaskManager;

    /// @notice when applied to a function, ensures that the function is only callable by the `registryCoordinator`.
    modifier onlyBorrowableEVCVaultTaskManager() {
        require(
            msg.sender == address(borrowableEVCVaultTaskManager),
            "onlyBorrowableEVCTaskManager: not from credible vault task manager"
        );
        _;
    }

    constructor(
        IAVSDirectory _avsDirectory,
        IRegistryCoordinator _registryCoordinator,
        IStakeRegistry _stakeRegistry,
        IBorrowableEVCVault _borrowableEVCVaultTaskManager
    )
        ServiceManagerBase(
            _avsDirectory,
            // IPaymentCoordinator(address(0)), // inc-sq doesn't need to deal with payments
            _registryCoordinator,
            _stakeRegistry
        )
    {
        borrowableEVCVaultTaskManager = _borrowableEVCVaultTaskManager;
    }

    /// @notice Called in the event of challenge resolution, in order to forward a call to the Slasher, which 'freezes'
    /// the `operator`.
    /// @dev The Slasher contract is under active development and its interface expected to change.
    ///      We recommend writing slashing logic without integrating with the Slasher at this point in time.
    function freezeOperator(address operatorAddr) external onlyBorrowableEVCVaultTaskManager {
        // slasher.freezeOperator(operatorAddr);
    }
}
