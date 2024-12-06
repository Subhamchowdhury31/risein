module MyModule::VotingSystem {

    use aptos_framework::signer;

    /// Struct representing the voting tally.
    struct VoteTally has store, key {
        yes_votes: u64,
        no_votes: u64,
    }

    /// Initializes a new VoteTally with zero votes.
    public fun create_vote(owner: &signer) {
        let vote_tally = VoteTally {
            yes_votes: 0,
            no_votes: 0,
        };
        move_to(owner, vote_tally);
    }

    /// Function to cast a vote.
    /// `vote` is true for "yes" and false for "no".
    public fun cast_vote(voter: &signer, vote: bool, vote_owner: address) acquires VoteTally {
        let tally = borrow_global_mut<VoteTally>(vote_owner);

        if (vote) {
            tally.yes_votes = tally.yes_votes + 1;
        } else {
            tally.no_votes = tally.no_votes + 1;
        }
    }

    /// Function to get the current vote tally.
    public fun get_tally(vote_owner: address): (u64, u64) acquires VoteTally {
        let tally = borrow_global<VoteTally>(vote_owner);
        (tally.yes_votes, tally.no_votes)
    }
}
