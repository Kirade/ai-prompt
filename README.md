# AI Prompt Repository

AI Assistant를 사용하는데 도움이 되는 프롬프트들을 관리하는 저장소입니다.

## 구조

```
ai-prompt/
├── claude/
│   ├── CLAUDE.md      # Claude Code용 기본 프롬프트
│   └── convention.md  # 코드 컨벤션 가이드라인
└── README.md
```

## 사용 방법

### Claude Code

1. Claude Code에서 프로젝트를 열 때, `@claude/CLAUDE.md` 파일이 자동으로 읽혀집니다.
2. CLAUDE.md 파일은 다른 마크다운 파일들을 참조하여 모듈화된 프롬프트 관리가 가능합니다.
3. 예시: convention.md 파일은 코드 작성 시 따라야 할 컨벤션을 정의합니다.

## 파일 설명

### claude/CLAUDE.md
- Claude Code가 기본적으로 읽는 프롬프트 파일
- 3단계 프로세스(탐색, 계획, 구현)를 통한 체계적인 작업 수행 지침 포함
- 다른 가이드라인 파일들에 대한 참조 링크 포함

### claude/convention.md
- 코드 작성 시 따라야 할 컨벤션과 스타일 가이드
- 언어별 (JavaScript/TypeScript, Python, React) 구체적인 가이드라인
- 에러 처리, 테스팅, 버전 관리 등의 모범 사례

## 기여 방법

새로운 프롬프트나 가이드라인을 추가하려면:
1. 적절한 디렉토리에 새 마크다운 파일 생성
2. CLAUDE.md에 해당 파일에 대한 참조 추가
3. 명확하고 구체적인 지침 작성

## 라이선스

이 저장소는 개인 프로젝트로 관리됩니다.