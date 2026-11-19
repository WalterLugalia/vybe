# VYBE Navigation

## Primary destinations

VYBE has five primary destinations and no others.

| Destination | Main responsibility |
|---|---|
| Discover | Personalized video discovery |
| Circles | Interest-based communities |
| Create | Recording and publishing |
| Missions | Challenges and collaboration |
| Profile | User identity and account management |

## Sections inside Discover

Watch, Explore and Participate are sections inside Discover.
They are not separate primary destinations.

## Outside the main navigation

Authentication, registration, account recovery, profile setup and
interest selection are separate from the five destinations.

## Structure

```text
Authentication (outside the shell)
Post-registration setup (outside the shell)
Main application (five-destination shell)
├── Discover
├── Circles
├── Create
├── Missions
└── Profile
```

## How routes are added

A route, its path and its name are added in the same change that
builds its screen. No route exists before its screen.

The main shell is added when the first destination screen exists.
Each further destination joins the shell in the phase that builds it.