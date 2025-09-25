import { FaHeadphones, FaMicrophone, FaSkull, FaUsers, FaWalkieTalkie } from "react-icons/fa6"
import { cn } from "../lib/utils";
import { useEffect, useState } from "react";

interface RadioUserProps {
    name: string;
    id?: string;
    isTalking?: boolean;
    isDead?: boolean;
}

export const RadioUser = ({
    name,
    id,
    isTalking,
    isDead
}: RadioUserProps) => {
    return (
        <div className="text-xs flex items-center justify-between w-full">
            <div className={cn("flex gap-2 items-center text-neutral-400 text-xs font-semibold w-3/4 truncate pr-1 transition", isTalking && "text-primary", isDead && "text-red-500")}>
                {isDead ? (
                    <FaSkull />
                ): isTalking ? (
                    <FaMicrophone />
                ): (
                    <FaHeadphones />
                )}
                {name.length > 15 ? name.substring(0, 15) + "..." : name}
            </div>
            {id && (
                <div className={cn("text-xs font-semibold text-neutral-500 w-1/4 text-end truncate transition", isTalking && "text-neutral-400")}>
                    {"[" + id.toString().padStart(4, '0') + "]"}
                </div>
            )}
        </div>
    )
}

// padStart(maxLength: number, fillString?: string): string;

interface RadioListData {
    name: string;
    members: RadioUserProps[];
}

export const RadioList = () => {
    const [show, setShow] = useState(true);
    const [data, setData] = useState<RadioListData | null>(
        {
            name: "",
            members: [
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                {
                    name: "! MTK",
                    id: "42",
                    isTalking: true,
                    isDead: false
                },
                
            ]
        }
    );

    useEffect(() => {
        interface MessageData {
            eventName: "nui:radio:update",
            show?: boolean;
            data?: RadioListData;
        }

        const onMessage = ({ data }: MessageEvent<MessageData>) => {
            if (data.eventName === "nui:radio:update") {
                if (data.show !== undefined) {
                    setShow(data.show);
                }

                if (data.data) {
                    setData(data.data);
                }
            }
        }

        window.addEventListener("message", onMessage);

        return () => window.removeEventListener("message", onMessage);
    }, []);

    return (
        <>
            {data && (
                <div className={cn("bg-custom-black/80 w-[230px] rounded-lg p-2 flex flex-col gap-3 fixed left-4 top-1/2 -translate-y-1/2 text-white transition origin-left", !show && "opacity-0 scale-0")}>
                    <header className="bg-custom-black rounded-md flex items-center justify-between p-2">
                        <div className="flex gap-1.5 items-center">
                            <FaWalkieTalkie className="text-neutral-400 text-xs" />
                            <p className="font-semibold text-xs text-neutral-400">Radio: <strong className="font-semibold text-white">{data.name}</strong></p>
                        </div>
                        <div className="flex gap-1.5 items-center">
                            <FaUsers className="text-neutral-400 text-xs" />
                            <strong className="font-semibold text-xs text-white">{data.members.length}</strong>
                        </div>
                    </header>
                    <div className="flex flex-col gap-1.5 transition">
                        {data.members
                            .sort((a, b) => {
                                if (a.isTalking && !b.isTalking) {
                                    return -1;
                                }
                                if (!a.isTalking && b.isTalking) {
                                    return 1;
                                }
                                return 0;
                            })
                            .slice(0, 10)
                            .map((member, key) => (
                                <RadioUser
                                    key={key}
                                    {...member}
                                />
                            ))}
                    </div>
                    {data.members.length > 10 && (
                        <p className="text-xs text-neutral-400 font-semibold">
                            {data.members.length - 10} Więcej
                        </p>
                    )}
                </div>
            )}
        </>
    )
}