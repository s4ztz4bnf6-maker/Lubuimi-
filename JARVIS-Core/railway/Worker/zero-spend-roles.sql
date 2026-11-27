-- SPDX-License-Identifier: LicenseRef-DJO2-Proprietary
-- Copyright (c) 2026 Ta-Yoshua Lubuimi. All rights reserved.
-- Prepared migration; inspect existing effective privileges before activation.
BEGIN;
CREATE ROLE djo2_zero_spend_reader NOLOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT NOREPLICATION NOBYPASSRLS;
CREATE ROLE djo2_zero_spend_authorizer NOLOGIN NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT NOREPLICATION NOBYPASSRLS;
REVOKE ALL ON public.djo2_zero_spend_routes FROM PUBLIC;
GRANT USAGE ON SCHEMA public TO djo2_zero_spend_reader,djo2_zero_spend_authorizer;
GRANT SELECT ON public.djo2_zero_spend_routes TO djo2_zero_spend_reader;
GRANT SELECT,INSERT ON public.djo2_zero_spend_routes TO djo2_zero_spend_authorizer;
GRANT UPDATE (revoked_at,updated_at) ON public.djo2_zero_spend_routes TO djo2_zero_spend_authorizer;
-- No role membership or production credential changes in this migration.
ROLLBACK;
