# 2024-NC2-M34-HealthKit
## 🎥 Youtube Link
(추후 만들어진 유튜브 링크 추가)

## 💡 About HealthKit
> 💪HealthKit은 사용자의 개인 정보 보호 및 제어를 유지하면서 건강 및 피트니스 데이터에 엑세스하고 공유는 프레임워크
- 개인 정보 보호 및 제어 : 각 앱이 어떤 건강 데이터에 접근 할 수 있는지 직접 선택 또는 변경 가능
- 종합 건강 데이터 관리 : 사용자의 다양한 건강 및 피트니스 데이터를 한 곳에 통합관리
- 앱 간의 데이터 공유 : 앱과 데이터를 서로 공유하여 사용 가능
- 친화적인 인터페이스 제공 : 쉽게 사용할 수 있는 API와 다양한 도구, 데이터 사용 가능

<br/>
HealthKit이 가지고 있는 데이터는 다양한 종류로 있다.
- 심장
- 수면
- 운동성
- 활동 등

## 🎯 What we focus on?
> **심박수 데이터** <br/> 심박수 데이터에 집중하였고, 심박수 데이터에는 데이터 읽기, 쓰기, 분석이 가능. <br/>데이터 읽기, 쓰기와 분석을 통해 활동을 추적하고, 심박수 패턴을 분석할 수 있다.

## 💼 Use Case
> **사용자** <br/> 설정한 심박수 범위에 맞춰서 효과적으로 운동을 열심히 하고 싶은 사람
- 선수를 준비하는 빈치가 운동 시에 고강도 훈련에 알맞는 심박수를 유지하도록 도와주어 운동능력을 향상 시킬 수 있도록 한다(고강도 운동)
- 심폐지구력을 올리고 싶은 나나가 러닝을 뛸 때 최대한의 운동 효과를 얻도록 도와준다(심폐지구력 향상 목적)
- 효과적으로 체지방을 없애고 싶은 정혜정이 운동을 할 때 지방 감소와 체중 감소가 쉽게 이루어 질 수 있는 최적의 운동 컨디션을 유지하도록 도와준다(다이어트 목적)

## 🖼️ Prototype

- 나이와 운동목적을 입력하면 유지해야 하는 심박수 범위를 알려준다.
<img width="419" alt="image" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M34-HealthKit/assets/72793532/fc6ff426-8e14-4c4e-ba4c-6d1aa78144f5">

<br/> 

- 운동중 실시간 심박수를 보여주고, 심박수가 목표 범위에서 벗어나면 진동과 함께 알람이 울린다.
<img width="419" alt="image" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M34-HealthKit/assets/72793532/ffb783e6-b929-4198-96b7-34c7a7b9d9ed">


<br/>

- 일시 정지, 운동 재개 버튼, 운동 종료 버튼
<img width="419" alt="image" src="https://github.com/DeveloperAcademy-POSTECH/2024-NC2-M34-HealthKit/assets/72793532/c49a60d9-5992-40b5-9c9d-b9eae557d657">


## 🛠️ About Code
- healthkit을 사용하여 사용자의 심박수 데이터를 가져오고 관리하는 클래스에서 requestHeartRatePermission()이 동작되면 HealthKit에서 심박수 데이터를 읽을 수 있는 권한을 요청

    func requestHeartRatePermission() {
        let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate)!
        
        healthStore.requestAuthorization(toShare: [], read: [heartRateType]) { (success, error) in
            if success {
                self.startHeartRateQuery()
            } else {
                print("건강 데이터에 대한 권한을 얻지 못했습니다.")
            }
        }
      

- 사용자에게 권한 요청이 성공하면 startHeartRateQuery()를 호출하여 심박수 데이터를 쿼리하기 시작한 후, 쿼리는 처음 실행될 때와 업데이트될 때 모두 process()를 호출하여 새로운 데이터를 처리

      func startHeartRateQuery() {
          guard let heartRateType = HKObjectType.quantityType(forIdentifier: .heartRate) else { return }
          
          let query = HKAnchoredObjectQuery(type: heartRateType, predicate: nil, anchor: anchor, limit: HKObjectQueryNoLimit) { (query, samples, deletedObjects, newAnchor, error) in
              self.anchor = newAnchor
              self.process(samples: samples)
          }
          
          query.updateHandler = { (query, samples, deletedObjects, newAnchor, error) in
              self.anchor = newAnchor
              self.process(samples: samples)
          }
          
          healthStore.execute(query)
      }

- process()에서 HealthKit에서 가져온 샘플 데이터를 처리하여 가장 최근의 심박수 샘플을 가져와서 heartRate 속성을 업데이트합니다.

      private func process(samples: [HKSample]?) {
        guard let samples = samples as? [HKQuantitySample] else { return }
        
        if let sample = samples.last {
            let heartRateUnit = HKUnit.count().unitDivided(by: HKUnit.minute())
            let value = sample.quantity.doubleValue(for: heartRateUnit)
            DispatchQueue.main.async {
                self.heartRate = value
                
              }
          }
      }



