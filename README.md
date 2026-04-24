# Chinese Study Web

개인용 중국어 학습 웹앱입니다.  
Vercel로 배포하고, Supabase 매직링크 로그인 + 스냅샷 동기화로 여러 기기에서 이어서 공부할 수 있게 구성했습니다.

## 핵심 기능
- 단어 학습 / 오답 복습 / SRS 우선순위
- 상황별 회화 카드
- 초급 회화용 핵심 문법 카드
- 사용자 단어 직접 추가
- 즐겨찾기
- Supabase 자동 동기화
- JSON 백업 / 복원
- PWA 설치 대응

## 배포 파일
- `index.html`
- `manifest.webmanifest`
- `sw.js`
- `icon.svg`
- `vercel.json`

## 로컬 실행
정적 파일 앱이라 간단한 로컬 서버로 열면 됩니다.

```powershell
python -m http.server 8787
```

그다음 브라우저에서 `http://127.0.0.1:8787/` 접속

## Supabase 연결
1. Supabase 프로젝트 생성
2. `supabase_setup.sql` 실행
3. Authentication > URL Configuration 설정
4. 앱의 동기화 화면에서 로그인

## 친구와 같이 쓸 수 있나?
가능합니다.  
같은 앱 URL을 공유해도 **각자 자기 이메일로 로그인하면 데이터가 분리**됩니다.  
같은 이메일 계정을 같이 쓰면 같은 데이터가 보입니다.
