import 'package:encrypt/encrypt.dart';
class RSTextData {

  // Encryption Keys
  static final _key = Key.fromUtf8('32554657765867879879879876000000');
  static final _iv = IV.fromBase64('gScioPT85qqx5d/ExwMvbw==');

  static String _decrypt(String base64) {
    final encrypter = Encrypter(AES(_key));
    return encrypter.decrypt64(base64, iv: _iv);
  }

  // 动态拼接文本（保留方法格式，因包含参数）
  static String deadline(String date) {
    return 'Deadline: $date';
  }

  // 动态拼接文本
  static String levelUpValue(String level) {
    return 'Level $level Reward';
  }

  // 动态拼接文本
  static String diamondPerEdit(String num) {
    return '$num diamond/edit';
  }

  // 动态拼接文本
  static String subscriptionInfo(String price, String unit) {
    return 'You will be charged $price immediately, then $price/$unit thereafter. Your subscription automatically renews unless canceled at least 24 hours before the end of the current period.';
  }

  // 动态拼接文本
  static String vipPriceLtDesc(String price) {
    return 'You will be charged $price immediately for lifetime access.';
  }

  // 动态拼接文本
  static String vipGet2(String diamond) {
    return '{{icon}}😄 Call your AI Girlfriend\n{{icon}}🥰 Spicy Photo, Video & Audio\n{{icon}}💎 One-time gift of $diamond diamond\n{{icon}}👏🏻 Unlimited messages & NSFW chats\n{{icon}}🔥 All access to premium features\n{{icon}}❤️ No ads';
  }

  // 动态拼接文本
  static String skuGetImage(String diamond) {
    return '{{icon}} High priority generation\n{{icon}} One-time gift of $diamond gems\n{{icon}} 4 Images per job\n{{icon}} Can generate N#FW image\n{{icon}}Text/Image-to-Image';
  }

  // 动态拼接文本
  static String skuGetVideo(String diamond) {
    return '{{icon}} High priority generation\n{{icon}} One-time gift of $diamond gems\n{{icon}} Can generate N#FW image';
  }

  // 动态拼接文本
  static String ageYearsOlds(String age) {
    return '$age years old';
  }

  static final String positiveReviewTitle = _decrypt('p7GKtmR7WkjWr6w6SDhTzA==');

  // 动态拼接文本
  static String oneTimePurchaseNote(String price) {
    return 'Please note that a one-time purchase will result in a one-time charge of $price to you.';
  }

  // 动态拼接文本
  static String saveNum(String num) {
    return 'Save $num%';
  }

  static String get ai_upload_steps =>
      _decrypt('0vD+mGQuCXDatLogPR4coeOP2vqOIB+hwFCBEn8fBcrrYDZkBPrgfj2+stiVIfZ1Nw1V6bEdTcRMhBN/I+o3pZu64TYh99WrBzXAQegqyZa2l3xMRiOdtZCS0vCMQK/Pmd5onvepHuHfDUvFLXmrMuXKDxKXbl/8MwjYToZY6tM=');
  static String get bestOffer => _decrypt('oZv5uytBPEL6ls8cG01qyw==');
  static String get editChooseMask =>
      _decrypt('t7bDnCttEmXL5Kh2by4NqfXO1rucIA7pwkWdVX8HAs7hJTEmNPb+fjm6sp2VJfFkeHUT555SDt9YgENkPr5isJHooCgm7MmhBjXCRrssjrm/kWoQbGLWk5Sfz+WBDqnD39hvlaPsEfPIC1fbLX6qMf2FTXDpBnz4NwzcSoJc7tc=');
  static String get gifts => _decrypt('pLfMm3gFcQ+0z8IRFkBnxg==');
  static String get introTitle => _decrypt('qrDenWQFcQ+0z8IRFkBnxg==');
  static String get ai_prompt_examples_img => _decrypt('hvDN1StsE2/WqqA2cSICqumc17/jDGPFoyjiMlNnYaM=');
  static String get deleteMaskConfirmation =>
      _decrypt('p7vGin9nFGOfsKFzbmsBrP+Fnq2GbAPp3UGdSjAZCI/hJTNpGPX/fjmzvcnHM+dkbW4JoIxcTfRWmgV5I/Mowg==');
  static String get ai_most_popular => _decrypt('rrHZmyteFXTKqKhoGU9oyQ==');
  static String get legal => _decrypt('r7vNjmcFcQ+0z8IRFkBnxg==');
  static String get searchSirens => _decrypt('t6faiitvWkreqaw6aSRMq+WA2vq8aR2swVfoOFlta6k=');
  static String get seach => _decrypt('sLvLnWhmcA61zsMQF0Fmxw==');

  static String get vipGet1 =>
      _decrypt('mKXDjGRgB3mfgad+cS4fvqyN1rubdAanyC6VRTYIAsH4PXVdA/XkPTH7vdGLYOR5dXMCtYx4FsxQlwx+LOM3gpC+oCgq/cXkGXrLQuhhgJS2i2hCIXXej5KHt+qTCa2AkdF60MLgVebOAUCnCAzGWA==');
  static String get tapToSeeMessages => _decrypt('yfSAxSFaG3SfsKY6bi4J7fiG2/qCZRy6zkOLTX9BR4WvalsGY5eFUFTV0rPpTowe');
  static String get textMessageCallCost =>
      _decrypt('0v7einN6Wmnat7p7ei5W7b7O2rOObQCnyy6tXzMHTe7MYDZgDOvqPS6+rs7dYLMgOWMOppIdA9MWmQp+VZoTxw==');
  static String get textMessageCost =>
      _decrypt('0v7einN6Wmnat7p7ei5W7b7O2rOObQCnyy7fHj4eCcbqYDhtHurqOT/h/InHJOtxdGgJo/UxDNtV1CJZcf1/ooapojIs6tL+VCSfB6wuwZW2i2tNIXnd6en3tJjhacfm');
  static String get moansForYou => _decrypt('rrHLgXguHGvN5LB1aEhvzg==');
  static String get ageHint => _decrypt('s7LPjnhrWm3RtLxuPTIDuP7O372KC2TCpC/lNVRgZqQ=');
  static String get yes => _decrypt('urvZ4gYDdwmyycQXEEZhwA==');
  static String get sendAGiftAndGetAPicture => _decrypt('sLvEiytvWmPWor06fCUI7euLyvqOIB+gzFCbTDpobqw=');
  static String get otherInfoHint =>
      _decrypt('urHfnSt8H2jesKB1czgEpPzOybObaE+9x0HOXTcKH87mNDB6Tfb5fjO2rNKVNON+bScCsZocGcQX82QXVpkQxA==');
  static String get violence => _decrypt('tbfFg25gGWG3zMESFUNkxQ==');
  static String get ai_styles => _decrypt('sKrTg259QA22zcATFEJlxA==');
  static String get ai_custom_prompt => _decrypt('oKvZm2RjWlTNq6RqaXFuzw==');
  static String get microphonePermissionRequired =>
      _decrypt('rrfJnWR+EmvRoelqeDkBpP+d17WBIAa6j1aLTyoCH8rhYCFnTfTqNT/7vZ2EIe58NwhoyPB9Yrg2+2wfXpEYzA==');
  static String get profileMaskDescription =>
      _decrypt('oKzPjn9rWmWfqahpdmscv+OI17aKIBumj02ASjoZDMzxYCJhGfGrKjK+/N6PIfBxenMCtd8QCMNNkRE+cdN4p52uuC8n/4GwHHCPSqk0y9i9imoRIjfHwIGY2/SLFO6bl8knnOzlHOXYREjDfmLkLrHAR3n/ACbfNg3dS4Nd79Y=');
  static String get unlockRoleDescription =>
      _decrypt('obvJgGZrWmWftLt/cCIZoKya0fqabgOmzE/OVjAfTd3qLDB7TfjlOnq8ucnHNex8cGoOs5oWTdRRlRdjf50UwA==');

  static String get enticingPicture => _decrypt('prDehmhnFGOftKB5aT4eqJz+rsr/EH/ZvzT+Lk97fb8=');
  static String get chatted => _decrypt('oLbLm39rHg22zcATFEJlxA==');
  static String get all => _decrypt('orLG4gYDdwmyycQXEEZhwA==');
  static String get gotToPro => _decrypt('pLGKm2QuKnbQw84dGkxryg==');
  static String get wait30Seconds =>
      _decrypt('qqqKgmp3WnDer6w6aDtMuePOjerPcwqqwEqKTXE7AcrkMzAoCfarMDWv/N6LL/F1OWgV55MXDMFc1Bd4NL52s4THzklGl67LexqgKMdIr/c=');
  static String get unlockRole => _decrypt('trDGgGhlWkzQsOlIcicJvq3hsdXgD2DGoCvhMVBkYqA=');
  static String get chatList => _decrypt('oLbLmytiE3fLw84dGkxryg==');
  static String get waitForResponse => _decrypt('s7LPjnhrWnPerb06eyQe7fiG2/qdZRy5wEqdW1tvaas=');
  static String get hotVideo => _decrypt('q7Hez11nHmHQw84dGkxryg==');
  static String get saraReceivedYourGift => _decrypt('sL/Yjit8H2farb9/eWsVovmcnr2GZhvpX7tgv1tvaas=');
  static String get create => _decrypt('oKzPjn9rcA61zsMQF0Fmxw==');
  static String get ai_bonus => _decrypt('obHEmngFcQ+0z8IRFkBnxg==');
  static String get networkError => _decrypt('s7LPjnhrWmfXoapxPT8EqKyA266Ybx2ij0eBUDEODtvsLzsFYJSGU1fW0bDqTY8d');
  static String get unselectAll => _decrypt('trDZimdrGXCfhaV2GU9oyQ==');
  static String get levelUpIntimacy => _decrypt('r7vcimcuD3SfjadudCYNrvXhsdXgD2DGoCvhMVBkYqA=');
  static String get yourNickname => _decrypt('urHfnStgE2fUqqh3eEhvzg==');
  static String get ai_language => _decrypt('opdIb5N9Wmjeqq5vfCwJ7eWdsNThDmHHoSrgMFFlY6E=');
  static String get clickSaveToConfirm =>
      _decrypt('oLLDjGAuDmza5OtJfD0J76yMy66bbwHp20vOXTAFC8b3LXV8Bfj/fjOv/MmGK+djOWIBoZoRGb4w/WoZWJceyg==');

  static String get noSubscriptionAvailable => _decrypt('rbGKnH5sCWfNrbludCQC7e2Y37ODYQ2lyiPpOVhsaqg=');
  static String get save => _decrypt('sL/cigcCdgizyMUWEUdgwQ==');
  static String get maxInputLength => _decrypt('rr/ShmZ7FyTWqrlvaWsAqOKJyrLVIFr5nwSNVj4ZDMzxJSd7YZWHUlbX0LHrTI4c');
  static String get feedback => _decrypt('pbvPi2lvGW+3zMESFUNkxQ==');
  static String get unlockTextReply => _decrypt('trDGgGhlWlDavL06Ty4cofXhsdXgD2DGoCvhMVBkYqA=');
  static String get clearHistoryFailed => _decrypt('oLLPjnkuEm3MsKZoZGsBqP+d372Kc0+vzk2CWztKb60=');
  static String get reportSuccessful => _decrypt('sbvagHl6WnfKp6p/bjgKuODhsdXgD2DGoCvhMVBkYqA=');
  static String get unlock => _decrypt('trDGgGhlcA61zsMQF0Fmxw==');
  static String get listening => _decrypt('r7fZm25gE2rY6uc0GU9oyQ==');
  static String get home => _decrypt('q7HHigcCdgizyMUWEUdgwQ==');
  static String get hotPhoto => _decrypt('q7Hez3tmFXDQw84dGkxryg==');
  static String get createOrderError => _decrypt('oKzPjn9rWmvNoKxoPS4ev+OcsNThDmHHoSrgMFFlY6E=');
  static String get easterEggUnlock =>
      _decrypt('oLHEiHlvDnefq6c6aCUAou+F17SIIBuhygSrXywfCN2lJTJvTf/uPy6urtjGYNt/bCcEppFSA9hO1BZgPfF2p9ShrCcu/dLkAHqPQrA3zJergC8WJHWTlY6az/SbE+6JisJkhOrrFq6cI0zUaCmqKbHEAWzyDCbQNg3dS4Nd79Y=');
  static String get vipMember => _decrypt('tZf6z0ZrF2bats8cG01qyw==');
  static String get clothing => _decrypt('oLLFm2NnFGO3zMESFUNkxQ==');
  static String get msgTips => _decrypt('sbvag2JrCSTetqw6ei4CqP6Pyr+LIA2wj2WCHj4FCY/jJSFhAvfqMlLT1LXvSIoY');
  static String get realistic => _decrypt('sbvLg2J9Dm3cw84dGkxryg==');
  static String get dislike => _decrypt('rbHez3hvDm3MoqB/eWdMo+mL2qnPaQK53UuYWzIOA9urT1oHYpaEUVXU07LoT40f');
  static String get ai_most_popular_new => _decrypt('rrHZmyteFXTKqKhoGU9oyQ==');
  static String get anime => _decrypt('orDDgm4FcQ+0z8IRFkBnxg==');
  static String get toCreate => _decrypt('t7GKjHlrG3Daw84dGkxryg==');
  static String get yourAge => _decrypt('urHfnStPHWG3zMESFUNkxQ==');
  static String get notEnough => _decrypt('qrDZmm1oE2fWoaduPSkNoe2A3b/DIB+lykWdW38ZCMztISdvCJKAVVHQ17bsS4kb');
  static String get personalDetails => _decrypt('s7vYnGRgG2ifoKxufCIAvpz+rsr/EH/ZvzT+Lk97fb8=');
  static String get message => _decrypt('jrvZnGppHw22zcATFEJlxA==');
  static String get messages => _decrypt('rrvZnGppHw22zcATFEJlxA==');
  static String get ai_photo_label => _decrypt('s7bFm2QFcQ+0z8IRFkBnxg==');
  static String get subFeedback => _decrypt('sKvIgmJ6WmWfoqx/eSkNrufhsdXgD2DGoCvhMVBkYqA=');
  static String get dailyReward => _decrypt('p7/Dg3IuCGHIpbt+GU9oyQ==');
  static String get weekly => _decrypt('tLvPhGd3cA61zsMQF0Fmxw==');
  static String get ai_art_consumes_power =>
      _decrypt('pKzPjn8uG3bL5Kp1czgZoOmdnrmAbR+820WaVzAFDMOlMDp/COurPzS//MmOLec+OUIRoo0LTcRclwx+Nb5urIHoticg7IGtBzXbVakp0562l2ILIneTiY6K0rGYCbaKk98nn+WkD+/SAEDQIwrAXg==');
  static String get upgradeTochat => _decrypt('tq7NnWpqHyTLq+l5dSoYzA==');
  static String get ai_purchase_balance => _decrypt('s6vYjGNvCWGfhqh2fCUPqJz+rsr/EH/ZvzT+Lk97fb8=');
  static String get unlockNow => _decrypt('trDGgGhlWkrQs88cG01qyw==');
  static String get otherInfo => _decrypt('rKrCinkuE2rZq88cG01qyw==');
  static String get lifetime => _decrypt('r7fMin9nF2G3zMESFUNkxQ==');
  static String get clearHistoryConfirmation =>
      _decrypt('oqzPz3JhDyTMsbt/PT8D7e+C27udIA6lwwSGVywfAt38YDhtHurqOT+o47jiRYcV');
  static String get longReply => _decrypt('r7HEiCtcH3TTvfM6cSIHqKydyrWdeWXDpS7kNFVhZ6U=');
  static String get vipUpgrade => _decrypt('tq7NnWpqHyTLq+lMVBtuzw==');

  static String get aotoTrans => _decrypt('prDLjWdrWmXKsKZ3fD8FrqyazLuBcwOo202BUGBobqw=');
  static String get resetChatBackground => _decrypt('sbvZmyttEmXL5Kt7fiALv+Ob0L7jDGPFoyjiMlNnYaM=');
  static String get ai_please_enter_custom_prompt =>
      _decrypt('s7LPjnhrWmHRsKxoPSpMrvmdyrWCIB+7wEmeSltvaas=');
  static String get yourName => _decrypt('urHfnStAG2naw84dGkxryg==');
  static String get yourGender => _decrypt('urHfnStJH2rbobsfGE5pyA==');
  static String get pleaseInput => _decrypt('s7LPjnhrWmHRsKxoPSgDo/iL0K7jDGPFoyjiMlNnYaM=');
  static String get aiPhoto => _decrypt('opeKv2NhDmu3zMESFUNkxQ==');
  static String get nice => _decrypt('rbfJigcCdgizyMUWEUdgwQ==');
  static String get typeHere => _decrypt('t6faiitmH3ba6uc0GU9oyQ==');
  static String get notEnoughCoins => _decrypt('rbHez25gFXHYrOlZciICvqDO3buDbE+swUCLWnFobqw=');
  static String get buyGemsOpenChats => _decrypt('oavTz0xrF3efsKY6cjsJo6yN1rubc0HApi3nN1ZiZKY=');
  static String get illegalDrugs => _decrypt('qrLGimxvFiTbtrx9bkhvzg==');
  static String get report => _decrypt('sbvagHl6cA61zsMQF0Fmxw==');
  static String get chooseYourTags => _decrypt('oLbFgHhrWn3Qsbs6aSoLvpz+rsr/EH/ZvzT+Lk97fb8=');
  static String get expirationTime => _decrypt('pqbahnlvDm3QquludCYJ96zhsdXgD2DGoCvhMVBkYqA=');
  static String get dressUp => _decrypt('p6zPnHguL3S3zMESFUNkxQ==');
  static String get subscribe => _decrypt('sKvInGh8E2baw84dGkxryg==');
  static String get yearly => _decrypt('urvLnWd3cA61zsMQF0Fmxw==');
  static String get shortReply => _decrypt('sLbFnX8uKGHPqLAgPScFpunOzbecC2TCpC/lNVRgZqQ=');
  static String get appVersion => _decrypt('oq7az31rCHfWq6cfGE5pyA==');
  static String get setChatBackground => _decrypt('oKvZm2RjWkfXpb06XyoPpuuc0a+BZGXDpS7kNFVhZ6U=');
  static String get micPermission =>
      _decrypt('rrfJnWR+EmvRoelqeDkBpP+d17WBIAa6j1aLTyoCH8rhYCFnTfTqNT/7vZ2EIe58NwhoyPB9Yrg2+2wfXpEYzA==');
  static String get ai_generate_another => _decrypt('pLvEinlvDmGfpad1aSMJv6yB0L/jDGPFoyjiMlNnYaM=');
  static String get male => _decrypt('rr/GigcCdgizyMUWEUdgwQ==');
  static String get btnContinue => _decrypt('oLHEm2JgD2G3zMESFUNkxQ==');
  static String get send => _decrypt('sLvEiwcCdgizyMUWEUdgwQ==');
  static String get liked => _decrypt('r7fBim8FcQ+0z8IRFkBnxg==');
  static String get subscriptionAutoRenew =>
      _decrypt('urHfz3xnFmifpqw6fiMNv+uL2vqGbQKsy02PSjoHFIOlND1tA7n/Nj/7r9yKJaJxdGgSqYtSCMFchhowPPF5t5zotS4s6sSlEmHKVeZn+Zesly8ROXLAg5KXzeWBD6DPntlzn+7lDOnfBUnOdCmxOP/AVmy6FjydW3amY+g0ib1tU7ZsVwVHsdd4vJyJuoOK6WmAWY4daRokXCyL8QOUvrMYeBkE1fGAMK2tptfUD1b0uebRqgqePTB48AUOGLd0S6G7GN+GLqOIB9Uoef3cpT4aAZIBtRoud84D9k8/CQYLBAhvN1E4nMFKp79qNRnE+g4rumLOzs1b+VYMGIhalFdCInVCyvB+5FCbcWOzVgzlClnP20/benUCe3POh2qJpdb3klRyo9W/BU36ep0Cag==');
  static String get selectProfileMask => _decrypt('sLvGimh6Wl3Qsbs6TTkDq+WC2/qiYRyipyzmNldjZac=');
  static String get uploadAPhoto => _decrypt('tq7GgGpqWmWftKF1aSRuzw==');
  static String get description => _decrypt('p7vZjHlnCnDWq6cfGE5pyA==');
  static String get setting => _decrypt('sLvem2JgHQ22zcATFEJlxA==');
  static String get explore => _decrypt('pqbag2R8Hw22zcATFEJlxA==');
  static String get vipGet =>
      _decrypt('mKXDjGRgB3mfNFaCnmspo+iC26mcIAyhzlCaVzEMZ9T+KTZnA+T2fqpEeQ7HFex8dmQM554eAZdfnQ9kNOxkyY+zqCUm9ty5VOUwtUZn4ZyvhGEBKXSTjY+a2LHOQKKAkcsnnebpF/LFbl7ZZGqsM+zYAe8F8t2wWiizMe4w5dw=');
  static String get backUpdatedSucc => _decrypt('ob/JhGx8FXHRoOlvbS8NuemKnqmaYwys3FeISzMHFI6VUEUYfYmbTkrLzK33UJIA');
  static String get upToVip => _decrypt('tq7NnWpqHyTLq+lMVBtuzw==');
  static String get ai_undress_sweetheart => _decrypt('trDOnW59CSTmq7xoPRgbqOma1r+Ochvp4UuZHn5Kb60=');
  static String get privacyPolicy => _decrypt('s6zDmWptAyTPq6VzfjJuzw==');
  static String get ai_photos => _decrypt('k7bFm2R9cA61zsMQF0Fmxw==');
  static String get openSettings => _decrypt('rK7PgSt9H3DLrad9bkhvzg==');
  static String get termsOfUse => _decrypt('t7vYgnguFWKfsbp/GU9oyQ==');
  static String get intro => _decrypt('qrDenWQFcQ+0z8IRFkBnxg==');
  static String get deleteChat => _decrypt('p7vGin9rWmfXpb0fGE5pyA==');

  static String get howToCallYou =>
      _decrypt('q7Hdz29hWn3QseltfCUY7fWBy6jPQSbpyE2cUjkZBMrrJHV8ArnoPza3/MSINb0R');
  static String get RSLoading => _decrypt('r7HLi2JgHQ22zcATFEJlxA==');
  static String get ai_video_label => _decrypt('tbfOimQFcQ+0z8IRFkBnxg==');
  static String get ai_prompt_examples_video =>
      _decrypt('hvDN1StPWnPQqah0PT8NpumdnrWJZk+hylbOXTMEGcfgM3koCOH7MSmystrHKOdiOWUVop4BGcQZlQ10cfB+s4SkpDVluM+lH3DLC+gyzpyrgHwRKXSfwI6L2fTsZMrr');
  static String get restore => _decrypt('sbvZm2R8Hw22zcATFEJlxA==');
  static String get giveHerAMoment =>
      _decrypt('pLfciitmH3afpel3ciYJo/jOyrXPZQGjwF3OVytLDMHhYCFpBvyrP3qrtd6TNfB1OWEItd8LAsIZBPyD5p0UwA==');
  static String get bestChatExperience => _decrypt('prDAgHIuLmza5It/bj9MjuSPyvqqeB+s3U2LUDwOb60=');
  static String get selectAll => _decrypt('sLvGimh6WkXTqM8cG01qyw==');

  static String get buy => _decrypt('oavT4gYDdwmyycQXEEZhwA==');
  static String get fillRequiredInfo =>
      _decrypt('s7LPjnhrWmLWqKU6dCVMueSLnqiKcRqg3UGKHjYFC8D3LTR8BPblV1PS1bTuSYsZ');
  static String get notSupport => _decrypt('rbHez3h7CnTQtr0fGE5pyA==');
  static String get spam => _decrypt('sK7LggcCdgizyMUWEUdgwQ==');
  static String get collect => _decrypt('oLHGg25tDg22zcATFEJlxA==');
  static String get tagsTitle => _decrypt('t7/NnAcCdgizyMUWEUdgwQ==');
  static String get info => _decrypt('qrDMgAcCdgizyMUWEUdgwQ==');
  static String get female => _decrypt('pbvHjmdrcA61zsMQF0Fmxw==');
  static String get reload => _decrypt('sbvGgGpqcA61zsMQF0Fmxw==');
  static String get descriptionHint =>
      _decrypt('r7fBijEuLWzesOl7by5MtOObzPqHbw2rxkGdAX8CHsPsKzAyTe7jPy77tc7HOe1laycDroweBNxcy0NHOf9j44CnsS8q64GgGzXWSL1nzJGygC8WIzDHgYyVnfCKD7ubwKMI/4yLd4+zayqtAgbMUg==');
  static String get childAbuse => _decrypt('oLbDg28uG2bKt6wfGE5pyA==');
  static String get speechRecognitionNotSupported =>
      _decrypt('sK7PimhmWnbap6Z9cyIYpOOAnrSAdE+62lSeUS0fCMulLzsoGfHiLXq/ucuOI+c+CRd31+9ifacp5HMAQY4H0w==');
  static String get toys => _decrypt('t7HTnAcCdgizyMUWEUdgwQ==');
  static String get ai_generation_failed =>
      _decrypt('pLvEinlvDm3Qqul8fCIAqOjA57WaIAyowQSaTCZLDMjkKTsoC/b5fjypudjGQ4ET');
  static String get confirm => _decrypt('oLHEiWJ8Fw22zcATFEJlxA==');
  static String get ai_under_character => _decrypt('trDOinkuDmza5KpyfDkNrviLzNfiDWLEoinjM1JmYKI=');
  static String get love => _decrypt('pKzPjn8vWk2Yqel2cj0Fo+vO167BC2TCpC/lNVRgZqQ=');
  static String get like => _decrypt('r7fBigcCdgizyMUWEUdgwQ==');

  static String get diamond => _decrypt('p7fLgmRgHg22zcATFEJlxA==');

  static String get scenarioRestartWarning =>
      _decrypt('t7GKjmh6E3La5L1yeGsCqPvOzbmKbg67xkvCSjcOTcztISEoGvDnfji+/M+CM/Zxa3NHppEWTcNRkUN4OO1jrIax4TEg9M3kGHrcQuZEo/s=');
  static String get popular => _decrypt('s7HammdvCA22zcATFEJlxA==');
  static String get monthly => _decrypt('rrHEm2NiAw22zcATFEJlxA==');
  static String get useAvatar => _decrypt('tq3Pz0piWmfXpbt7fj8Jv//JnrmAdgq7pyzmNldjZac=');
  static String get inputYourNickname => _decrypt('prDeinkuA2vKtul0dCgHo+2D29fiDWLEoinjM1JmYKI=');
  static String get year => _decrypt('mrvLnQcCdgizyMUWEUdgwQ==');
  static String get nonBinary => _decrypt('rbHEwmlnFGXNvc8cG01qyw==');
  static String get createMaskProfileDescription =>
      _decrypt('oKzPjn9rWmWfqahpdmscv+OI17aKIBumj02ASjoZDMzxYCJhGfGrKjK+/N6PIfBxenMCtd8QCMNNkREVVJsSxg==');
  static String get createProfileMask => _decrypt('oKzPjn9rWl3Qsbs6TTkDq+WC2/qiYRyipyzmNldjZac=');
  static String get maskAlreadyLoaded =>
      _decrypt('t7bDnCttEmXL5Kh2by4NqfXO1rucIA7pwkWdVX8HAs7hJTEmTcDkK3q4vdPHMudjbWYVs98TTdRRlRcwJfE3toet4Scn99WsEWePSqk0y9b5pGkWKWKTkoWNyfCaFKeBmIAnhOvhWOjVF1HNf3DjKvjJTT/2DCGUEALSRIxS4Nk=');
  static String get ai_generate => _decrypt('pLvEinlvDmG3zMESFUNkxQ==');
  static String get everyDay => _decrypt('zLrLlgcCdgizyMUWEUdgwQ==');
  static String get video => _decrypt('tbfOimQFcQ+0z8IRFkBnxg==');
  static String get close => _decrypt('oLLFnG4FcQ+0z8IRFkBnxg==');
  static String get activateBenefits => _decrypt('or3ehn1vDmGfhqx0eC0Fuf/hsdXgD2DGoCvhMVBkYqA=');
  static String get copyright => _decrypt('oLHalnlnHWzLw84dGkxryg==');
  static String get day => _decrypt('h7/T4gYDdwmyycQXEEZhwA==');
  static String get replyMode => _decrypt('sbvag3IuF2vboc8cG01qyw==');
  static String get ai_view_nude => _decrypt('tbfPmCt6EmGfp6F7byoPuemcmanPbhqtyiPpOVhsaqg=');
  static String get optionTitle => _decrypt('rK7ehmRgcA61zsMQF0Fmxw==');
  static String get more => _decrypt('rrHYigcCdgizyMUWEUdgwQ==');
  static String get ai_videos => _decrypt('lbfOimR9cA61zsMQF0Fmxw==');
  static String get ai_generating_masterpiece =>
      _decrypt('pLvEinlvDm3Ro+ljcj4e7eiH2bObYQPpwkWdSjoZHcbgIzAmQ7eBVFDR1rftSoga');
  static String get deleteChatConfirmation =>
      _decrypt('oqzPz3JhDyTMsbt/PT8D7eiL0r+bZU+9x02dHjwDDNu6T1oHYpaEUVXU07LoT40f');
  static String get ai_make_photo_animated => _decrypt('rr/Biit3FXHN5Llycj8D7e2A17eOdAqtjwygbRk8RK4=');
  static String get ai_generating => _decrypt('opeKqG5gH3besKB0emVC45z+rsr/EH/ZvzT+Lk97fb8=');
  static String get noNetwork => _decrypt('rbGKgW56DWvNr+l5ciUCqO+a17WBC2TCpC/lNVRgZqQ=');
  static String get noChat => _decrypt('rbGKjGNvDg22zcATFEJlxA==');
  static String get month => _decrypt('jrHEm2MFcQ+0z8IRFkBnxg==');
  static String get freeChatUsed =>
      _decrypt('urHfyH1rWnHMoa06aDtMtOObzPqJcgqsj0eGXytLDt3gJDx8HrerCjX7v9KJNOt+bGJHopEYAs5QmgQwPutl44etszAg+8ToVGXDQqk0xdi6imERJXTWksCLzfaaAaqGkcsnhOykF/XORFXQaGSqKPyFUXP7DXz4NwzcSoJc7tc=');
  static String get pickIt => _decrypt('s7fJhCtnDg22zcATFEJlxA==');
  static String get pleaseInputCustomText =>
      _decrypt('s7LPjnhrWm3RtLxuPTIDuP7O3a+cdACkj1CLRitLBcr3JXsmQ5KAVVHQ17bsS4kb');
  static String get inputNickname => _decrypt('qrDamn8uA2vKtul0dCgHo+2D29fiDWLEoinjM1JmYKI=');
  static String get ai_balance => _decrypt('ob/GjmVtHz63zMESFUNkxQ==');
  static String get ai_max_input_length =>
      _decrypt('rr/ShmZ7FyTWqrlvaWsAqOKJyrLVIFr5nwSNVj4ZDMzxJSd7YZWHUlbX0LHrTI4c');
  static String get nickname => _decrypt('rbfJhGVvF2G3zMESFUNkxQ==');
  static String get support => _decrypt('sKvan2R8Dg22zcATFEJlxA==');
  static String get clearHistorySuccess => _decrypt('oLLPjnkuEm3MsKZoZGsBqP+d372Kc0+62keNWywYTK4=');
  static String get someErrorTryAgain =>
      _decrypt('q7PHDYuoWnPa5KV1bj9MruOA0L+MdAamwQSIUS1LDI/nKSEmTcnnOzuouZ2TMvsweGAGrpFTZ70z/mkaW5QdyQ==');
  static String get language => _decrypt('orJIb5J9Wmjeqq5vfCwJzA==');
  static String get iapNotSupport => _decrypt('qp/6z2VhDiTMsblqcjkYqOjhsdXgD2DGoCvhMVBkYqA=');
  static String get maskApplied =>
      _decrypt('t7bPz2ZvCW+frKhpPSkJqOLOzq+bIACnj0KBTH8SAtqkYBhnCfDtJzO1u52TKOcwdGYUrN8WAtJKmkRkcf9xpZGrtWY98MTkGHrOQ60jgJW4lmRFPzDWhoab3uXGY83s');
  static String get getAiInteractiveVideoChat =>
      _decrypt('pLvez2pgWkX25KB0aS4erO+a16yKIBmgy0GBHjwDDNulJS14COviOzS4ubjiRYcV');
  static String get waitingResponse => _decrypt('tL/Dm2JgHSTNobpqciUfqG5uGNfiDWLEoinjM1JmYKI=');

  static String get bestChoice => _decrypt('obvZmyttEmvWp6wfGE5pyA==');
  static String get invitesYouToVideoCall => _decrypt('qrDchn9rCSTGq7w6aSRMu+WK27XPYw6lw8ZumFtvaas=');
  static String get submit => _decrypt('sKvIgmJ6cA61zsMQF0Fmxw==');
  static String get ai_generate_nude => _decrypt('pLvEinlvDmGfpel0aC8JzA==');
  static String get ai_best_value => _decrypt('obvZmytYG2jKoc8cG01qyw==');
  static String get week => _decrypt('lLvPhAcCdgizyMUWEUdgwQ==');
  static String get scenario => _decrypt('sL3PgWp8E2u3zMESFUNkxQ==');
  static String get ai_upload_steps_extra =>
      _decrypt('0vD+mGQuCXDatLogPR4coeOP2vqOIB+hwFCBEn8fBcrrYDZkBPrgfj2+stiVIfZ1Nw1V6bEdTcRMhBN/I+o3pZu64TYh99WrBzXAQegqyZa2l3xMRiOdtZCS0vCMQK/Pmd5onvepHuHfDUvFLXmrMuXKDxWuTRaeW3b1LeQhx619T6NnBRAT/M5xqYaN9tSeuWSAXJALaQgpVTeW5w3i1A==');
  static String get edit => _decrypt('prrDmwcCdgizyMUWEUdgwQ==');
  static String get ai_image_to_video => _decrypt('qrPLiG4uDmufkqB+eCRuzw==');
  static String get nameHint => _decrypt('t7bPz2VvF2GfsKF7aWsVovnOybuBdE+rwFCdHisETczkLDkoFPb+V1PS1bTuSYsZ');
  static String get clearHistory => _decrypt('oLLPjnkuEm3MsKZoZEhvzg==');
  static String get editScenario => _decrypt('prrDmyt9GWHRpbtzckhvzg==');
  static String get tips => _decrypt('t7fanAcCdgizyMUWEUdgwQ==');
  static String get accept => _decrypt('qqqNnCthEWXG6Ol5cj4AqayM2/qNZRu9ylbAO1puaKo=');
  static String get restart => _decrypt('sbvZm2p8Dg22zcATFEJlxA==');
  static String get chat => _decrypt('oLbLmwcCdgizyMUWEUdgwQ==');
  static String get autoTrans => _decrypt('oqvegGZvDm3c5J1ofCUfoe2a17WBC2TCpC/lNVRgZqQ=');
  static String get cancel => _decrypt('oL/EjG5icA61zsMQF0Fmxw==');
  static String get noData => _decrypt('rbGKi2p6Gw22zcATFEJlxA==');
  static String get openChatsUnlock =>
      _decrypt('rK7PgSttEmXLt+l7cy9MmOKC0bmEICem2wSeVjAfAoOlEDp6A7ndNz6+s5HHDe1xd3RL57gXA9JLlRd1cdd6opOtsmZvuPetEHDAVORn45m1iS8lJWLfk8H5upbvZ8no');
  static String get ai_ai_photo => _decrypt('opeKv2NhDmu3zMESFUNkxQ==');
  static String get undrMessage =>
      _decrypt('trDOnW59CSTeqrB1cy5MrOKXyrOCZU7p40uBVX8cBc7xZyYoGPfvOyj7tNiVYOF8dnMPooxTZ70z/mkaW5QdyQ==');
  static String get tryNow => _decrypt('t6zTz0VhDSW3zMESFUNkxQ==');
  static String get Moments => _decrypt('rrHHimV6CQ22zcATFEJlxA==');
  static String get undress => _decrypt('trDOnW59CQ22zcATFEJlxA==');
  static String get tease => _decrypt('t7vLnG4FcQ+0z8IRFkBnxg==');
  static String get mask => _decrypt('rr/ZhAcCdgizyMUWEUdgwQ==');
  static String get tryIt => _decrypt('t6zTz0J6cA61zsMQF0Fmxw==');
  static String get aiGenerateImage => _decrypt('opeKiG5gH3besKw6dCYNqunhsdXgD2DGoCvhMVBkYqA=');
  static String get keyGeneration => _decrypt('qLvTmGR8HiT4oad/byoYpOOAsNThDmHHoSrgMFFlY6E=');
  static String get textToPicture => _decrypt('t7vSmyt6FSTvrapuaDkJzA==');
  static String get basics => _decrypt('ob/Zhmh9cA61zsMQF0Fmxw==');
  static String get height => _decrypt('q7vDiGN6cA61zsMQF0Fmxw==');
  static String get gender => _decrypt('pLvEi258cA61zsMQF0Fmxw==');
  static String get imageStyle => _decrypt('qrPLiG4uCXDGqKwfGE5pyA==');
  static String get nsfw => _decrypt('rY3suAcCdgizyMUWEUdgwQ==');
  static String get moreDetails => _decrypt('rrHYiitqH3DeraVpGU9oyQ==');
  static String get years => _decrypt('urvLnXgFcQ+0z8IRFkBnxg==');
  static String get cm => _decrypt('oLOk4QUAdAqxyscUE0Viww==');
  static String get real => _decrypt('sbvLgwcCdgizyMUWEUdgwQ==');
  static String get fantasy => _decrypt('pb/Em2p9Aw22zcATFEJlxA==');
  static String get ns => _decrypt('qq2Khn8uNFf5k+FUcj9Mvu2I2/qJbx3p2EucVXZUb60=');
  static String get ageMust => _decrypt('grnPz2Z7CXCfpqw6fy4YuumL0PreOE+owUDOB2ZSb60=');
  static String get heightMust => _decrypt('i7vDiGN6WmnKt706fy5Mr+mayb+Kbk/4nwSPUDtLVJa8T1oHYpaEUVXU07LoT40f');
  static String get age => _decrypt('ornP4gYDdwmyycQXEEZhwA==');
  static String get createImage => _decrypt('oKzPjn9rWk3Spa5/GU9oyQ==');
  static String get describeImage => _decrypt('p7vZjHlnGGGfvaZvb2sFoO2J29fiDWLEoinjM1JmYKI=');
  static String get creations => _decrypt('oKzPjn9nFWrMw84dGkxryg==');
  static String get including =>
      _decrypt('sKvNiG59DiTWqqp2aC8Fo+vO2r+bYQalykDOSDYYGM7pM3VkBPLufjy6v9SGLKJ2fGYTso0XHpsZlQR1fb5nrIe8tDQstIGlAGHGVa1rgJm3gS8ALXPYh5KRyP+MTszt');
  static String get aiWrite => _decrypt('opeKmHlnDmG3zMESFUNkxQ==');
  static String get failedGenerate =>
      _decrypt('pb/Dg25qWnDQ5K5/cy4erPiLnrOCYQisgQS+UjoKHsqlNCdxTfjsPzO18rjiRYcV');
  static String get errorGenerate => _decrypt('orCKinl8FXafq6p5aDkeqOjAnoqDZQ66ygSaTCZLDMjkKTsmYZWHUlbX0LHrTI4c');
  static String get loadingIdNull => _decrypt('irqKhnguFHHTqOU6bScJrP+Lnq6deU+oyEWHUFtvaas=');
  static String get createMore => _decrypt('oKzPjn9rWknQtqwfGE5pyA==');
  static String get imagePermission =>
      _decrypt('sKrFnWppHyTPobt3dDgfpOOAnrOcIB2s3lGHTDoPTdvqYCZpG/yrNze6u9iUQ4ET');
  static String get imageSaved => _decrypt('qrPLiG4uCWXJoa0fGE5pyA==');
  static String get downloadFailed => _decrypt('pb/Dg25qWnDQ5K11aiUAou2KnrOCYQispyzmNldjZac=');
  static String get noImages => _decrypt('rbGKpmZvHWHMw84dGkxryg==');
  static String get noImagesText =>
      _decrypt('r7veyHguCXDetr06fjkJrPiH0L2RCjam2lbOXS0ODNvsLzt7Te7iMjb7vtjHM/Z/a2ID55cXH9IX82QXVpkQxA==');
  static String get delete => _decrypt('p7vGin9rcA61zsMQF0Fmxw==');
  static String get selectItem => _decrypt('s7LPjnhrWnfaqKx5aWsNo6yHyr+CIAmg3VeaEFtvaas=');
  static String get rules => _decrypt('savGingFcQ+0z8IRFkBnxg==');
  static String get clear => _decrypt('oLLPjnkFcQ+0z8IRFkBnxg==');
  static String get numberofimages => _decrypt('ravHjW58WmvZ5IB3fCwJvpz+rsr/EH/ZvzT+Lk97fb8=');
  static String get imageRatio => _decrypt('qrPLiG59WlbesKB1GU9oyQ==');
  static String get loadingTimeoutWithCreditRefund =>
      _decrypt('rLHanCouKWvSob1ydCUL7fuL0K7Pdx2mwUPAHhsEA4jxYCJnH+vycnqis8iVYOFifGMOs4xSBdZPkUNyNPt544attTM79sSgVGHAB7Eo1Yr5hGwBI2XdlM75upbvZ8no');
  static String get defaultDescription =>
      _decrypt('oLHFgytpE3bT6OlpdSQeuayM0bjPaA6g3UebSnNLGcrmKCJtDOurNjW0uNSCbKJ0eHUM54wHA9BVlRBjNO0744G6oycnuNS0BHDdCqooxIH5lmcNOD656ur0t5viasTl');
  static List<String> get inputTagsTest => [
    _decrypt('tLbLm+mO43efsKF/PSYDvvjO3bKKcga6x0GKHjYFGcboISFtTfTuMzWppZ2eL/fymZ4Rot8XG9JL1A5xNfs3tJ28qWYo9s6wHHDdB7gi0ou2izBvQR2+7e3zsJzlbcPi'),
    _decrypt('q7Hdz2Z7GWyfrKh0eThBouLO26KfZR2gykqNW38PAo/8LyAoBfj9O3qstcmPYPB/dGYJs5YRTdZXkENgOedkqpeprWY7/c2lAHzASbsvyYiq2gFsQh697u7ws5/mbsDh'),
    _decrypt('q7/ciit3FXGfob9/b2sOqOmAnrOBIA7p3UGCXysCAsH2KDx4Te7iKjL7r9KKJe1+fCcQr5BSAtlakUN0MOpyp9SxrjM7uMe2HXDBQ/dEo/s='),
    _decrypt('tLbPnW4uHm3b5LB1aDlMq+Wcza7PcgCkzkqaVzxLDMHhYDxmGfDmPy6+/NiJI+1ld3MCtd8GDNxc1BN8MP1y/OTY0VZZiLHUZAW/N9hXsOg='),
    _decrypt('qriKlmR7WmfQsaV+PTsFrufO37SWIAOmzEWaVzAFTcnqMnVpA7niMC6+ss6CLPswa2gKppEGBNQZmQx9NPBj79S/qSM7/YGzG2DDQ+g+z435lmoOKXPH3+j2tZngaMbn'),
    _decrypt('qq2Km2NrCGGfpelqfDkYpO+b0rudIBy91kiLHjAZTdjkOXVnC7nqLiqps9yEKOt+ficXr4YBBNRYmEN5P+p+rpWruGY98MCwVGzAUughwY62lzBvQR2+7e3zsJzlbcPi'),
    _decrypt('tLHfg28uA2vK5Kt/PTwFoeCH0L3PdADpylyeUjAZCI/rJSIoGfHiMD2o/MqPJewwcHNHpJAfCMQZgAwwOPBjqpmptSNp/dm0EWfGQqYkxYvm6gBtQx+87+/xsp7nb8Hg'),
    _decrypt('p7GKlmR7WmLWqq06fGsPuP6Yx/qfaBa6xlWbW38EH4/kYCZrGPX7Kj+/8J2TL+x1fScFqJsLTdpWhgYwMO5nppWkqCgup6vOfh+lLcJNqvI='),
    _decrypt('oL/Ez3JhDyTctqx7aS5MrKyc0beObhugzASDUTIOA9ulND1pGbn4MTe+s9OCYPV5dWtHr5AeCZdQmkNkOft+sdSlpCsm6tjkEnrdQr4i0sfJ9R9yXACj8PDurYH4cN7/'),
    _decrypt('tLbLmyt6E2na5KZ8PS8NtKyBzPqcaRu8zlCHUTFLAM7uJSYoFPb+fja0strHJu1iOWZHtZAfDNlNnQAwMvF5rZGrtS8m9oGwHHCPSqc01MfJ9R9yXACj8PDurYH4cN7/'),
    _decrypt('tLHfg28uA2vK5Kt/PSgDoOqBzK6OYgOsj1eGXy0CA8ilMzplCO3jNzS8/M2CMvF/d2YL55AATcdLnRVxJfs3opantDJp4c6xBmbKS65n15GtjS8PKS+56ur0t5viasTl'),
    _decrypt('tLHfg28uA2vK5Kt/PSICuemc26mbZQvpxkrOTToFCcbrJ3VpA/2rLD+4udSRKex3OXUIqp4cGd5a1Axicfd5t52loDIsuNGsG2HAVPdEo/s='),
    _decrypt('oLHfg28uA2vK5LpyfDkJ7e3OzrOMdBq7ygSBWH8SAtr3MzBkC7n8Ny6z/NCCf4AS'),
    _decrypt('tLbLm+mO43efsKF/PSYDvvjOzqiAZgC8wUDOTDAGDMHxKTYoD/blOnqis8gFwBtmfCcCsZoATcRRlRF1Nb5gqoCg4TUm9cSrGnCQIs1Cpf0='),
    _decrypt('q7/ciit3FXGfob9/b2sErOjO3/qdbwKowVCHXX8OFd/gMjxtA/rufi6zvcnHJud8bScEqJICAdJNkQ9pcft5oJyprzIg9sbkG2ePSqkgyZu4iTBvQR2+7e3zsJzlbcPi'),
    _decrypt('tLHfg28uA2vK5Kt/PSQcqOLOyrXPZReqx0WAWTYFCo/1JSd7AvfqMnqrtNKTL/Ewf3UIqt8LAsJL1BF/PP95t52r4Ssm9cSqAGaQIs1Cpf0='),
    _decrypt('tLHfg28uA2vK5KRzcy9MpOrO9/qOcwSsywSaUX8YCMqlIXV4BPr/Kyi+/NKBYPt/bDhpyfF8Y7k3+m0eX5AZzQ=='),
    _decrypt('q7/ciit3FXGfob9/b2sErOjO37TPaQG9xkmPSjpLAMDoJTt8Te3jPy77vdGTJfB1fSceqIoATcdchhBgNP1jqoKt4SknuNOrGXTBRK14ovo='),
    _decrypt('tLbLm+mO43efvaZvb2sYtPyH3buDIBio1gSBWH8YBcDyKTtvTfDlKjO2vd6eYOt+OWZHtZAfDNlNnQAwI/t7ooChrig68Mi0SxKoIM9Ap/8='),
  ];
  static String get answer =>
      _decrypt('t7fanDEuI2vK5Kp7c2sZvunOyrKKIE2cwUCcWywYT4/nNSF8AverKjX7r9WIN6JpdnIV54ocCcVchxB5P/k3sICxrSNp7M7kDXraVeg3wYqti2oQYhu46+v1tprja8Xk');
}