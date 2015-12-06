- [ ] Refactor to pull the `light_sources` out of Party.
- [ ] Refactor the specs to produce model specs for the various objects.
- [ ] Add specs (and fix models) so individual light sources (and other various
resources in the future) can be tracked separately.
  - [ ] Light sources need to be removed from the Party's resources when the burn
  out.
  - [ ] This should effect the `#alerts` generated in predictable ways.
- [ ] Add color "hints" to alerts
  - i.e. `<RED>Movement: Party is tired!. They now have a penalty of...`
