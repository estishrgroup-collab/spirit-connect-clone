
-- Restrict bin_cache SELECT to admins only (edge function uses service_role which bypasses RLS)
DROP POLICY IF EXISTS "Anyone can read bin cache" ON public.bin_cache;
REVOKE SELECT ON public.bin_cache FROM anon;
REVOKE SELECT ON public.bin_cache FROM authenticated;
GRANT SELECT ON public.bin_cache TO authenticated;
CREATE POLICY "Admins can read bin cache"
ON public.bin_cache FOR SELECT TO authenticated
USING (public.has_role(auth.uid(), 'admin'));

-- Restrict SECURITY DEFINER function EXECUTE from anon
REVOKE EXECUTE ON FUNCTION public.has_role(uuid, public.app_role) FROM PUBLIC, anon;
REVOKE EXECUTE ON FUNCTION public.claim_admin_if_empty() FROM PUBLIC, anon;
GRANT EXECUTE ON FUNCTION public.has_role(uuid, public.app_role) TO authenticated, service_role;
GRANT EXECUTE ON FUNCTION public.claim_admin_if_empty() TO authenticated, service_role;
