# 중국어 학습앱 배포/동기화 설정

## 추천 조합
- Vercel: 정적 웹앱 배포
- Supabase: 매직링크 로그인 + 학습 데이터 저장
- localStorage: 캐시/오프라인 임시 저장
- JSON 백업: 수동 복구용

## 1. Vercel 배포
1. 이 폴더를 GitHub에 올립니다.
2. Vercel에서 해당 저장소를 Import 합니다.
3. Framework Preset은 `Other` 또는 `Static`으로 둡니다.
4. 배포 후 발급된 URL을 복사합니다.

## 2. Supabase 준비
1. Supabase 프로젝트를 만듭니다.
2. `Project URL`과 `anon public key`를 복사합니다.
3. SQL Editor에서 `supabase_setup.sql` 내용을 실행합니다.
4. Authentication > URL Configuration 에서 다음을 등록합니다.
   - Site URL: Vercel 배포 주소
   - Redirect URLs: Vercel 배포 주소와 필요한 프리뷰 주소

## 3. 앱에서 연결
1. 앱의 `동기화` 탭을 엽니다.
2. `Project URL`, `anon key`, 이메일을 입력합니다.
3. `설정 저장` 후 `매직링크 로그인`을 누릅니다.
4. 메일에서 링크를 눌러 로그인합니다.
5. 이후부터는 같은 기기에서 홈 화면 아이콘 또는 링크 한 번으로 진입 가능합니다.

## 4. 아이폰/아이패드 PWA
1. Safari로 배포 URL을 엽니다.
2. 공유 버튼 > 홈 화면에 추가
3. 홈 화면 아이콘을 누르면 앱처럼 실행됩니다.

## 메모
- 첫 1회 로그인은 필요합니다.
- 이후에는 세션이 유지되므로 사실상 한 번 탭해서 바로 열리는 흐름이 됩니다.
- 동기화가 꼬였을 때를 대비해 JSON 백업 기능은 유지하는 것이 좋습니다.
