# RiverWare version notes

- When opening the model with RW 9.6.3, there was an error where "variable length time units are not allowed in RPL literal values", so it asked if I'd like to convert the following:

11 months into 8184 hr
1 year into 8760 hr

However the conversion may not have actually happened properly. I got an error when running the model, and then a Claude Code analysis showed:

 onversion never happened.

Evidence:
- Current `Eldorado.Public.V1.mdl` still has both original strings, byte-identical to pre-commit version:
  - "GetDates"( @"t", @"t + 11", "1 months" ) (rule `SetWholesalerAnnualQuota`, ~line 40362)
  - "GetDates"( @"t", @"t + 6", "1 months" ) (inactive branch of same rule, ~line 40370)
- Zero "N hours" strings anywhere in file — no hour-based equivalent ever written.
- Commit 69c0b2b changed 9208 lines in .mdl (RW 9.6.3 format resave), but these GetDates calls untouched.

Also note: @"t + 11" offsets (also in `SetBasinPercentFullSlots`, FOREACH ... @"t" TO @"t + 11", ~line 40389) still timestep-relative — if model now runs hourly, those mean "11 hours", not "11 months". That likely = same error you saw.

So RW 9.6.3 resave preserved ruleset verbatim; no month→hour conversion applied.