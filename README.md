# AI Prompt Repository

AI Assistant를 사용하는데 도움이 되는 프롬프트들을 관리하는 저장소입니다.

## 구조

```
ai-prompt/
├── claude/
│   ├── CLAUDE.md      # Claude Code용 기본 프롬프트
│   └── convention.md  # 코드 컨벤션 가이드라인
├── apply-prompts.sh   # 프롬프트 설치 스크립트
└── README.md
```

### 설치 후 프로젝트 구조

```
your-project/
├── CLAUDE.md          # 프로젝트 루트에 설치됨
└── .claude/
    └── ai-prompt/     # 보조 파일들
        └── convention.md
```

## 사용 방법

### Claude Code

1. 프로젝트 루트의 `CLAUDE.md` 파일이 자동으로 읽혀집니다.
2. CLAUDE.md 파일은 `.claude/ai-prompt/` 내의 다른 마크다운 파일들을 참조합니다.
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

## 프롬프트 적용 스크립트

이 저장소는 `apply-prompts.sh` 스크립트를 제공하여 프롬프트를 쉽게 적용할 수 있습니다.

### 설치

```bash
# 저장소 클론
git clone https://github.com/Kirade/ai-prompt.git
cd ai-prompt

# 스크립트 실행 권한 부여
chmod +x apply-prompts.sh
```

### 사용 방법

```bash
# 현재 디렉토리에 적용
./apply-prompts.sh

# 특정 프로젝트에 적용
./apply-prompts.sh ~/my-project

# 백업과 함께 적용
./apply-prompts.sh -b ~/my-project

# 심볼릭 링크로 적용 (원본 파일 참조)
./apply-prompts.sh -s ~/my-project

# 홈 디렉토리에 글로벌 적용
./apply-prompts.sh -g

# 글로벌 심볼릭 링크 적용
./apply-prompts.sh -g -s

# CLAUDE.md를 CLAUDE.local.md로 설치 (프로젝트 커스터마이징)
./apply-prompts.sh -l
```

### 옵션

- `-h, --help`: 도움말 표시
- `-f, --force`: 기존 파일 덮어쓰기 (확인 없이)
- `-b, --backup`: 기존 파일 백업 생성
- `-s, --symlink`: 파일 복사 대신 심볼릭 링크 생성
- `-g, --global`: 홈 디렉토리(~/.claude)에 글로벌 적용
- `-l, --local`: CLAUDE.md를 CLAUDE.local.md로 설치 (프로젝트별 커스터마이징용)

### 글로벌 vs 프로젝트별 설정

- **글로벌 설정**: 
  - `~/CLAUDE.md`: 홈 디렉토리의 전역 프롬프트
  - `~/.claude/ai-prompt/`: 전역 보조 파일들
- **프로젝트 설정**: 
  - `프로젝트/CLAUDE.md`: 프로젝트별 프롬프트
  - `프로젝트/.claude/ai-prompt/`: 프로젝트별 보조 파일들
- **로컬 커스터마이징** (`CLAUDE.local.md`): `-l` 옵션으로 프로젝트별 커스터마이징
  - Git에서 자동으로 제외됨 (.gitignore에 추가)
  - `.claude/ai-prompt/` 디렉토리도 함께 제외
  - 원본 CLAUDE.md를 수정하지 않고 프로젝트별 조정 가능
- 프로젝트 설정이 글로벌 설정보다 우선순위가 높습니다

## 라이선스

이 저장소는 개인 프로젝트로 관리됩니다.