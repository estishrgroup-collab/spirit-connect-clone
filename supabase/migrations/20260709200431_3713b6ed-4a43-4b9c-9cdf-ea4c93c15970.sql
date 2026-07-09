DROP POLICY IF EXISTS "Anyone can view active banners" ON public.ad_banners;

CREATE POLICY "Public can view active banners"
  ON public.ad_banners
  FOR SELECT
  TO anon, authenticated
  USING (active = true);

CREATE POLICY "Admins can view all banners"
  ON public.ad_banners
  FOR SELECT
  TO authenticated
  USING (public.has_role(auth.uid(), 'admin'));