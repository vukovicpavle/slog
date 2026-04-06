# Project brief: Slog — Local Community App

> **Status:** Draft · **Mode:** Greenfield · **Readiness:** Missing basics

## Problem or goal

Neighborhoods lack a dedicated digital space for local communication, event coordination, and collaborative decision-making. Residents rely on fragmented tools (group chats, social media, email chains) that are noisy, not neighborhood-scoped, and have no built-in way to reach agreements.

Slog gives a neighborhood a single place to share updates, discover and organize local events, message each other, and propose and reach agreements together.

## Target users

- **Residents** of a neighborhood or local community who want to stay informed and connected.
- **Community organizers** who create events, post updates, and facilitate group decisions.

## MVP scope

1. **Neighborhood feed** — residents post updates visible to their neighborhood.
2. **Local events** — create, discover, and RSVP to neighborhood events.
3. **Resident messaging** — direct messages between neighbors.
4. **Agreements / proposals** — residents propose topics, discuss, and vote to reach a group decision.
5. **Authentication** — sign up / sign in (Supabase Auth).
6. **Neighborhood membership** — join or create a neighborhood; content scoped to the neighborhood.

## Out of scope

> ⚠️ **Needs confirmation** — proposed defaults below.

- Payments or marketplace features
- Multi-neighborhood federation or cross-neighborhood content
- Admin moderation dashboard (beyond basic author controls)
- Push notifications (deferred to post-MVP)
- Media-heavy content (video uploads, stories)
- Analytics or reporting dashboards

## Platform

Cross-platform mobile and web app — **Expo (React Native)** targeting iOS, Android, and Web.

## Stack

| Layer | Choice |
|---|---|
| Runtime / framework | Expo (React Native) with Expo Router |
| Language | TypeScript |
| Backend / BaaS | Supabase (Postgres, Auth, Realtime, Storage) |
| Client SDK | `@supabase/supabase-js` |
| Styling | *(to be decided)* |

## UI/UX direction

> ⚠️ **Needs input** — no direction captured yet.

Proposed defaults (confirm or override):

- Friendly, approachable tone — light color palette with a community feel.
- Feed-first home screen; bottom tab navigation (Feed, Events, Messages, Agreements, Profile).
- Low-friction posting: tap-to-post with minimal required fields.
- Agreements use a simple propose → discuss → vote flow.

## Constraints and integrations

- **Auth:** Supabase Auth (email/password to start; social login deferred).
- **Realtime:** Supabase Realtime for live feed and messaging.
- **Storage:** Supabase Storage for profile images and event media.
- **Deployment:** Expo EAS for mobile builds; Supabase hosted for backend.

## Success criteria

> ⚠️ **Needs confirmation** — proposed defaults below.

1. A resident can sign up, join a neighborhood, and see the neighborhood feed.
2. A resident can post an update and it appears in the feed in real time.
3. A resident can create an event and others can RSVP.
4. Two residents can exchange direct messages.
5. A resident can create a proposal, others can discuss and vote, and the outcome is recorded.
